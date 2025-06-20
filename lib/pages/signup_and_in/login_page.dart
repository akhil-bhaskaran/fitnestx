import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/firebase_services/auth_services.dart';
import 'package:fitness/pages/dashboard/home_page.dart';
import 'package:fitness/pages/dashboard/main_dashboard.dart';
import 'package:fitness/pages/signup_and_in/forgot_pass.dart';
import 'package:fitness/pages/signup_and_in/signup.dart';
import 'package:fitness/pages/signup_and_in/text_field.dart';
import 'package:fitness/widgets/custom_button.dart';
import 'package:fitness/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCotroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showSnackbar(String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg!)));
  }

  Future<UserCredential?> login() async {
    try {
      UserCredential credential = await authServices.value.signin(
        email: emailCotroller.text.trim(),
        pass: passwordController.text.trim(),
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      showSnackbar(e.message);
      return null;
    }
  }

  void forgot() async {
    await authServices.value.forogtPass(email: emailCotroller.text.trim());
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
                      "Welcome Back",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    MyTextField(
                      hint: 'Email',
                      controller: emailCotroller,
                      icon: Icon(Icons.person_4_outlined),
                      isObesecure: false,
                    ),
                    MyTextField(
                      hint: 'Password',
                      icon: Icon(Icons.lock_outline),
                      isObesecure: true,
                      controller: passwordController,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot your Password?",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: const Color.fromARGB(255, 162, 162, 162),
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    // Spacer()
                    SizedBox(height: MediaQuery.of(context).size.height * .3),
                    Column(
                      children: [
                        MyElevatedButton(
                          label: 'Login',
                          onclick: () async {
                            if (emailCotroller.text == '') {
                              showSnackbar('Please Provide An Email');
                            } else if (passwordController.text == '') {
                              showSnackbar('Please Provide a Password');
                            } else {
                              showLoadingDialog(context);
                              UserCredential? credential = await login();
                              hideLoadingDialog(context);
                              if (credential == null) {
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainDashboardPage(),
                                  ),
                                );
                              }
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
                                    builder: (context) => Signup(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
