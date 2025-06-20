import 'package:fitness/pages/signup_and_in/text_field.dart';
import 'package:fitness/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DietPlanner extends StatefulWidget {
  const DietPlanner({super.key});

  @override
  State<DietPlanner> createState() => _DietPlannerState();
}

class _DietPlannerState extends State<DietPlanner> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _medicalConditionsController =
      TextEditingController();
  final TextEditingController _foodPreferencesController =
      TextEditingController();
  final TextEditingController _mealTimingController = TextEditingController();

  bool _isLoading = false;
  String _dietPlan = "";

  // Replace with your actual Gemini API key
  final String apiKey = "AIzaSyAT0c_lpnAn5EidGsKyfew3GxTKt3KYPhQ";
  final String apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  Future<void> _generateDietPlan() async {
    setState(() {
      _isLoading = true;
      _dietPlan = "Generating your personalized diet plan...";
    });

    try {
      // Collect all user inputs
      final Map<String, String> userInfo = {
        'age': _ageController.text.trim(),
        'gender': _genderController.text.trim(),
        'height': _heightController.text.trim(),
        'weight': _weightController.text.trim(),
        'activityLevel': _activityLevelController.text.trim(),
        'goal': _goalController.text.trim(),
        'medicalConditions': _medicalConditionsController.text.trim(),
        'foodPreferences': _foodPreferencesController.text.trim(),
        'mealTiming': _mealTimingController.text.trim(),
      };

      // Validate required fields
      if (!_validateRequiredFields(userInfo)) {
        setState(() {
          _isLoading = false;
          _dietPlan =
              "Please fill in all required fields (Age, Gender, Height, Weight, Activity Level, and Goal).";
        });
        return;
      }

      // Build the prompt for Gemini
      final String prompt = _buildGeminiPrompt(userInfo);

      // Make the API call to Gemini
      final dietPlan = await _callGeminiAPI(prompt);

      setState(() {
        _isLoading = false;
        _dietPlan = dietPlan;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _dietPlan = "Error generating diet plan: $e";
      });
    }
  }

  bool _validateRequiredFields(Map<String, String> userInfo) {
    // Check that all required fields are filled
    return userInfo['age']!.isNotEmpty &&
        userInfo['gender']!.isNotEmpty &&
        userInfo['height']!.isNotEmpty &&
        userInfo['weight']!.isNotEmpty &&
        userInfo['activityLevel']!.isNotEmpty &&
        userInfo['goal']!.isNotEmpty;
  }

  String _buildGeminiPrompt(Map<String, String> userInfo) {
    // Create a detailed prompt for the AI
    return '''
    As a professional nutritionist, create a personalized diet plan with the following information:
    
    Age: ${userInfo['age']}
    Gender: ${userInfo['gender']}
    Height: ${userInfo['height']} cm
    Weight: ${userInfo['weight']} kg
    Activity Level: ${userInfo['activityLevel']}
    Fitness Goal: ${userInfo['goal']}
    ${userInfo['medicalConditions']!.isNotEmpty ? 'Medical Conditions: ${userInfo['medicalConditions']}' : ''}
    ${userInfo['foodPreferences']!.isNotEmpty ? 'Food Preferences: ${userInfo['foodPreferences']}' : ''}
    ${userInfo['mealTiming']!.isNotEmpty ? 'Preferred Meal Timing: ${userInfo['mealTiming']}' : ''}
    
    Please provide:
    1. Daily calorie target
    2. Macronutrient breakdown (protein, carbs, fats)
    3. A 7-day meal plan with breakfast, lunch, dinner, and snacks
    4. Nutritional tips specific to their goals
    5. A sample grocery list
    
    Format the diet plan in a clear, organized way that's easy to read.
    ''';
  }

  Future<String> _callGeminiAPI(String prompt) async {
    // Prepare the request body
    final requestBody = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt},
          ],
        },
      ],
      "generationConfig": {"temperature": 0.7, "maxOutputTokens": 2048},
    });

    // Make the HTTP request
    final response = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      // Parse the response
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Extract the generated text from Gemini's response
      final String generatedText =
          data['candidates'][0]['content']['parts'][0]['text'];
      return generatedText;
    } else {
      throw Exception(
        'Failed to generate diet plan. Status code: ${response.statusCode}, Response: ${response.body}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: ListView(
          children: [
            const Text(
              "Fill the details correctly for a better healthy diet plan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Required fields
            const Text(
              "Required Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            MyTextField(
              controller: _ageController,
              hint: 'Age',
              icon: const Icon(Icons.numbers),
              isObesecure: false,
            ),
            MyTextField(
              controller: _genderController,
              hint: 'Gender',
              icon: const Icon(Icons.people),
              isObesecure: false,
            ),
            MyTextField(
              controller: _heightController,
              hint: 'Height (in cm)',
              isObesecure: false,
              icon: const Icon(Icons.height),
              // keyboardType: TextInputType.number,
            ),
            MyTextField(
              controller: _weightController,
              hint: 'Weight (in kg)',
              isObesecure: false,
              icon: const Icon(Icons.monitor_weight),
              // keyboardType: TextInputType.number,
            ),

            MyTextField(
              hint: 'Activity Level (e.g., Sedentary, Moderate, Active)',
              icon: const Icon(Icons.directions_run),
              isObesecure: false,
              controller: _activityLevelController,
            ),
            MyTextField(
              hint: 'Fitness Goal (e.g., Weight Loss, Muscle Gain)',
              icon: const Icon(Icons.fitness_center),
              isObesecure: false,
              controller: _goalController,
            ),

            // Optional fields
            const SizedBox(height: 20),
            const Text(
              "Optional Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            MyTextField(
              controller: _medicalConditionsController,
              hint: 'Medical Conditions (e.g., Diabetes, Allergies)',
              icon: const Icon(Icons.medical_information),
              isObesecure: false,
            ),
            MyTextField(
              controller: _foodPreferencesController,
              hint: 'Food Preferences (e.g., Vegetarian, No dairy)',
              icon: const Icon(Icons.restaurant_menu),
              isObesecure: false,
            ),
            MyTextField(
              controller: _mealTimingController,
              hint:
                  'Preferred Meal Timing (e.g., 3 meals, Intermittent fasting)',
              icon: const Icon(Icons.schedule),
              isObesecure: false,
            ),

            const SizedBox(height: 30),
            MyElevatedButton(
              label: _isLoading ? 'Generating...' : 'Generate Diet Plan',
              onclick: _isLoading ? null : _generateDietPlan,
            ),

            const SizedBox(height: 30),
            const Text(
              'Your Personalized Diet Plan:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),

            // Display the diet plan
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SelectableText(
                _dietPlan.isEmpty
                    ? "Your personalized diet plan will appear here after you fill out the form and click Generate."
                    : _dietPlan,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
