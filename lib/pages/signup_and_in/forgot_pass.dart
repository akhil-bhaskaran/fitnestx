import 'package:fitness/pages/signup_and_in/text_field.dart';
import 'package:fitness/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSubmitted = false;

  void _submit() async {
    if (_emailController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _isSubmitted = false;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    ); // fake wait (or your real password reset function)

    setState(() {
      _isLoading = false;
      _isSubmitted = true;
    });

    // ⏳ After showing success screen, wait 10 seconds then go back
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pop(context); // or Navigator.pushReplacement to Login Page
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Reset Password'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
              _isSubmitted
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Please check your email!',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'A password reset link has been sent to your email address.\n\nRedirecting you back in 10 seconds...',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),

                      MyElevatedButton(
                        label: "Back to Login Now",
                        onclick: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter your email address to reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // TextField(
                      //   controller: _emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      //   decoration: InputDecoration(
                      //     hintText: 'Enter your email',
                      //     hintStyle: TextStyle(fontSize: 15),
                      //     prefixIcon: const Icon(Icons.email, size: 20),

                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      // ),
                      MyTextField(
                        hint: 'Enter your email',
                        icon: Icon(Icons.email),
                        isObesecure: false,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 30),
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     onPressed: _submit,
                      //     child:
                      //         _isLoading
                      //             ? const CircularProgressIndicator(
                      //               color: Colors.white,
                      //               strokeWidth: 3,
                      //             )
                      //             : const Text('Send Reset Link'),
                      //   ),
                      // ),

                      ///
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: InkWell(
                          onTap: _submit,
                          borderRadius: BorderRadius.circular(12),
                          child:
                              _isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )
                                  : Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromARGB(
                                            255,
                                            78,
                                            173,
                                            220,
                                          ),
                                          const Color.fromARGB(
                                            255,
                                            42,
                                            99,
                                            122,
                                          ),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Text(
                                      "Send Reset link",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
