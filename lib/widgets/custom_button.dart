import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.path,
    this.ontap,
    required this.d,
  });

  final String path;
  final void Function()? ontap;
  final double d;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 60, // Make the button bigger
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white, // Optional background color
        ),
        child: Center(
          child: Image.asset(
            path,
            height: d, // Smaller than container
            width: d,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
