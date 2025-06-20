import 'package:fitness/firebase_services/auth_services.dart';
import 'package:fitness/firebase_services/database_services.dart';
// import 'package:fitness/model/user_model.dart';
import 'package:fitness/pages/signup_and_in/login_page.dart';
import 'package:fitness/pages/signup_and_in/profile_completion_page.dart';
import 'package:fitness/pages/signup_and_in/text_field.dart';
import 'package:fitness/widgets/custom_button.dart';
import 'package:fitness/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final DatabaseService _databaseService = DatabaseService();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailCotroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = '';
  bool checkValue = false;

  // bool _isLoading = true;
  // bool _isEditing = false;
  // UserProfile? _userProfile;

  void showSnackbar(String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg!)));
  }

  // Future<void> _saveProfile(String uid) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //    try {
  //       String userId = FirebaseAuth.instance.currentUser!.uid;
  //       UserProfile updatedProfile = UserProfile(
  //         id: userId,
  //         name: nameController.text,
  //         email: emailCotroller.text,
  //         height: double.parse(_heightController.text),
  //         weight: double.parse(_weightController.text),
  //         age: int.parse(_ageController.text),
  //         gender:'adsada'
  //       );

  //       await _databaseService.saveUserProfile(updatedProfile);

  //       setState(() {
  //         _userProfile = updatedProfile;
  //         _isEditing = false;
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Profile saved successfully')),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error saving profile: $e')),
  //       );
  //     }
  // }
  //REGISTER BUTTON FUNCTION
  Future<void> register() async {
    try {
      await authServices.value.signup(
        email: emailCotroller.text.trim(),
        pass: passwordController.text.trim(),
      );
      // final String uid = ae.user!.uid;
      // await _saveProfile(uid);
    } on FirebaseAuthException catch (e) {
      showSnackbar(e.message);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Hey There,",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Create An Account",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    MyTextField(
                      hint: 'First Name',
                      controller: nameController,
                      icon: Icon(Icons.person_4_outlined),
                      isObesecure: false,
                    ),
                    MyTextField(
                      hint: "Last Name",
                      icon: Icon(Icons.person_4_outlined),
                      isObesecure: false,
                      controller: lastNameController,
                    ),
                    MyTextField(
                      hint: 'Email',
                      icon: Icon(Icons.email_outlined),
                      isObesecure: false,
                      controller: emailCotroller,
                    ),
                    MyTextField(
                      hint: 'Password',
                      icon: Icon(Icons.lock_outline),
                      isObesecure: true,
                      controller: passwordController,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checkValue,
                          onChanged: (value) {
                            setState(() {
                              checkValue = value ?? false;
                            });
                          },
                        ),

                        // if (checkValue) const Icon(Icons.check, color: Colors.green),
                        Expanded(
                          child: Text(
                            "By continuing you accept our Privacy Policy and Term of Use",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    MyElevatedButton(
                      label: 'Register',
                      onclick: () async {
                        if (nameController.text.trim() == '') {
                          showSnackbar("Please Provide name");
                        } else if (checkValue == false) {
                          showSnackbar('Accept our Privacy and Policy');
                        } else if (emailCotroller.text == '') {
                          showSnackbar('Please Provide An Email');
                        } else if (passwordController.text == '') {
                          showSnackbar('Please Provide a Password');
                        } else {
                          showLoadingDialog(context);
                          await register();
                          hideLoadingDialog(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ProfileCompletionPage(
                                    email: emailCotroller.text,
                                    name:
                                        nameController.text.trim() +
                                        ' ' +
                                        lastNameController.text.trim(),
                                  ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          "or",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(path: 'assets/images/gg.png', d: 23),
                        SizedBox(width: 20),
                        CustomButton(path: 'assets/images/fb.png', d: 28),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already Have An Account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.purple),
                          ),
                        ),
                      ],
                    ),
                    //
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
