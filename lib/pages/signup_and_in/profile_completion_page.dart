import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/firebase_services/database_services.dart';
import 'package:fitness/model/user_model.dart';
import 'package:fitness/pages/dashboard/main_dashboard.dart';
import 'package:fitness/pages/signup_and_in/text_field.dart';
import 'package:fitness/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';

class ProfileCompletionPage extends StatefulWidget {
  const ProfileCompletionPage({
    super.key,
    required this.email,
    required this.name,
  });
  final String email;
  final String name;

  @override
  State<ProfileCompletionPage> createState() => _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends State<ProfileCompletionPage> {
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = true;
  bool _isEditing = false;
  UserProfile? _userProfile;

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      UserProfile updatedProfile = UserProfile(
        id: userId,
        name: widget.name,
        email: widget.email,
        height: double.parse(heightController.text),
        weight: double.parse(weightController.text),
        age: int.parse(ageController.text),
        gender: genderController.text,
      );

      await _databaseService.saveUserProfile(updatedProfile);

      setState(() {
        _userProfile = updatedProfile;
        _isEditing = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile saved successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
    }
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
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset('assets/images/pro1.png', fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Let’s complete your profile",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "It will help us to know more about you!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color.fromARGB(255, 128, 128, 128),
                  ),
                ),
                MyTextField(
                  hint: 'Choose Gender',
                  icon: Icon(Icons.group),
                  isObesecure: false,
                  controller: genderController,
                ),
                MyTextField(
                  hint: 'Weight(Kg)',
                  icon: Icon(Icons.monitor_weight),
                  isObesecure: false,
                  controller: weightController,
                ),
                MyTextField(
                  hint: 'Height(cm)',
                  icon: Icon(Icons.height),
                  isObesecure: false,
                  controller: heightController,
                ),
                MyTextField(
                  hint: 'Age',
                  icon: Icon(Icons.event),
                  isObesecure: false,
                  controller: ageController,
                ),
                MyElevatedButton(
                  label: "Next  >",
                  onclick: () async {
                    showLoadingDialog(context);
                    await _saveProfile();
                    hideLoadingDialog(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainDashboardPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
