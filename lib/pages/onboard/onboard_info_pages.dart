import 'package:flutter/material.dart';

class OnboardInfoPages extends StatelessWidget {
  const OnboardInfoPages({
    super.key,
    required this.img,
    required this.title,
    required this.content,
    required this.onPressed,
    required this.bimg,
  });
  final String img;
  final String bimg;
  final String title;
  final String content;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.85,
            child: Image.asset(img, fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 10),
                Text(content, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.transparent,
          elevation: 40,
          child: Image.asset(bimg, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
