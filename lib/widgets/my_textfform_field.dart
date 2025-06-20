import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    required this.hint,
    required this.icon,
    required this.isObsecure,
    required this.controller,
    this.maxLines = 1, // Default is 1 for a single-line field
    this.keyboardType = TextInputType.text, // Default keyboard type is text
    this.validator, // Optional validator
  });

  final String hint;
  final Icon icon;
  final bool isObsecure;
  final TextEditingController controller;
  final int maxLines; // To allow multiple lines of text
  final TextInputType
  keyboardType; // To specify the input type (e.g., email, number, etc.)
  final String? Function(String?)? validator;

  @override
  State<MyTextFormField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextFormField> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    isVisible = widget.isObsecure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isVisible ? true : false,
        maxLines: widget.maxLines, // Allow multiple lines for descriptive input
        keyboardType: widget.keyboardType,
        style: const TextStyle(fontSize: 15),
        validator: widget.validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ), // Rounded corners for better UI
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          prefixIcon: widget.icon,
          prefixIconColor: const Color.fromARGB(255, 162, 162, 162),
          suffixIcon:
              widget.isObsecure
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon:
                        isVisible
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                  )
                  : null,
          filled: true,
          fillColor: const Color.fromARGB(255, 243, 243, 243),
          labelText: widget.hint,
          labelStyle: const TextStyle(
            fontFamily: "Poppins",
            color: Color.fromARGB(255, 162, 162, 162),
            fontSize: 15,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }
}
