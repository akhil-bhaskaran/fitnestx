import 'package:fitness/constants.dart';
import 'package:fitness/pages/onboard/onboard_info_pages.dart';
import 'package:fitness/pages/signup_and_in/signup.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Centered Content
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text(
                      //   "FitnestX",
                      //   style: Theme.of(context).textTheme.bodyLarge,
                      // ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.black),
                          children: [
                            TextSpan(text: "Fitnest"),
                            TextSpan(
                              text: "X",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontSize: 35, color: purple),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Everybody Can Train",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            // 1
                            (context) => OnboardInfoPages(
                              title: 'Track Your Goal',
                              bimg: 'assets/images/B1.png',
                              content:
                                  "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
                              img: 'assets/images/Track.png',
                              onPressed:
                                  () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          //2
                                          (context) => OnboardInfoPages(
                                            img: 'assets/images/Burn.png',
                                            title: 'Get Burn',
                                            content:
                                                'Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever',
                                            bimg: 'assets/images/B2.png',
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      //3
                                                      (
                                                        context,
                                                      ) => OnboardInfoPages(
                                                        img:
                                                            'assets/images/Eat.png',
                                                        title: "Eat Well",
                                                        content:
                                                            "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
                                                        bimg:
                                                            'assets/images/B3.png',
                                                        onPressed: () {
                                                          Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              //4
                                                              builder:
                                                                  (
                                                                    context,
                                                                  ) => OnboardInfoPages(
                                                                    img:
                                                                        'assets/images/Yoga.png',
                                                                    title:
                                                                        "Improve Sleep \nQuality",
                                                                    content:
                                                                        "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning",
                                                                    bimg:
                                                                        'assets/images/B4.png',
                                                                    onPressed: () {
                                                                      Navigator.pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder:
                                                                              (
                                                                                context,
                                                                              ) =>
                                                                                  Signup(),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                    ),
                                  ),
                            ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(purple),
                  ),
                  child: Text(
                    "Get Started",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
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
