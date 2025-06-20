import 'package:fitness/firebase_services/auth_services.dart';
import 'package:fitness/model/user_model.dart';
import 'package:fitness/pages/signup_and_in/signup.dart';
import 'package:fitness/widgets/info_container.dart';
import 'package:fitness/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String name = '';
  int age = 0;
  double weight = 0;
  double height = 0;
  late SharedPreferences _prefs;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _prefs = await SharedPreferences.getInstance();

    // Load values with proper error handling
    final String nameValue = _prefs.getString("name") ?? "";

    // For numeric values, try to get them directly first
    int? ageValue = _prefs.getInt("age");
    double? weightValue = _prefs.getDouble("weight");
    double? heightValue = _prefs.getDouble("height");

    // If the numeric values don't exist as their correct type,
    // try to parse them from strings (in case they were saved as strings)
    if (ageValue == null) {
      final ageStr = _prefs.getString("age");
      if (ageStr != null) {
        ageValue = int.tryParse(ageStr);
      }
    }

    if (weightValue == null) {
      final weightStr = _prefs.getString("weight");
      if (weightStr != null) {
        weightValue = double.tryParse(weightStr);
      }
    }

    if (heightValue == null) {
      final heightStr = _prefs.getString("height");
      if (heightStr != null) {
        heightValue = double.tryParse(heightStr);
      }
    }

    setState(() {
      name = nameValue;
      age = ageValue ?? 0;
      weight = weightValue ?? 0.0;
      height = heightValue ?? 0.0;
      _isLoading = false;

      // Log the loaded values to debug
      print(
        "Loaded values - Name: $name, Age: $age, Weight: $weight, Height: $height",
      );
    });

    // Ensure values are saved in the correct format
    if (weightValue == null) {
      await _prefs.setDouble("weight", 0.0);
    }

    if (heightValue == null) {
      await _prefs.setDouble("height", 0.0);
    }
  }

  Future<void> _updateValue(String key, dynamic value) async {
    if (value == null) return;

    // Print debug information
    print("Updating $key with value: $value (${value.runtimeType})");

    if (value is String) {
      if (key == "name") {
        await _prefs.setString(key, value);
        setState(() {
          name = value;
        });
        print("Updated name to: $name");
      } else if (key == "age") {
        final ageValue = int.tryParse(value);
        if (ageValue != null) {
          await _prefs.setInt(key, ageValue);
          setState(() {
            age = ageValue;
          });
          print("Updated age to: $age");
        } else {
          print("Failed to parse age: $value");
        }
      } else if (key == "weight") {
        // Handle possible format issues (commas vs periods)
        String normalizedValue = value.replaceAll(',', '.');
        final weightValue = double.tryParse(normalizedValue);

        if (weightValue != null) {
          await _prefs.setDouble(key, weightValue);
          setState(() {
            weight = weightValue;
          });
          print("Updated weight to: $weight");
        } else {
          print("Failed to parse weight: $value");
          // Show error to user
          _showErrorSnackBar(
            "Invalid weight format. Please enter a valid number.",
          );
        }
      } else if (key == "height") {
        // Handle possible format issues (commas vs periods)
        String normalizedValue = value.replaceAll(',', '.');
        final heightValue = double.tryParse(normalizedValue);

        if (heightValue != null) {
          await _prefs.setDouble(key, heightValue);
          setState(() {
            height = heightValue;
          });
          print("Updated height to: $height");
        } else {
          print("Failed to parse height: $value");
          // Show error to user
          _showErrorSnackBar(
            "Invalid height format. Please enter a valid number.",
          );
        }
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (_) => Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(),
            ),
          ),
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              ProfileAvatar(imageUrl: "assets/images/Burn.png"),
              const SizedBox(height: 20),
              Text(
                name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              EditableInfoTile(
                label: "Name",
                initialValue: name,
                icon: Icons.person,
                onValueChanged: (value) => _updateValue("name", value),
              ),

              EditableInfoTile(
                label: "Age",
                initialValue: age.toString(),
                icon: Icons.calendar_today,
                onValueChanged: (value) => _updateValue("age", value),
              ),

              EditableInfoTile(
                label: "Weight (Kg)",
                initialValue: weight > 0 ? weight.toString() : "",
                icon: Icons.fitness_center,
                onValueChanged: (value) => _updateValue("weight", value),
              ),

              EditableInfoTile(
                label: "Height (cm)",
                initialValue: height > 0 ? height.toString() : "",
                icon: Icons.height,
                onValueChanged: (value) => _updateValue("height", value),
              ),

              const SizedBox(height: 48),

              ElevatedButton.icon(
                onPressed: () async {
                  showLoadingDialog(context);
                  await authServices.value.signout();
                  hideLoadingDialog(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 4, 0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
