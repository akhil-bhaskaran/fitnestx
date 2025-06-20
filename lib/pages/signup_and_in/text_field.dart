import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.isObesecure,
    required this.controller,
  });
  final String hint;
  final Icon icon;
  final bool isObesecure;
  final TextEditingController controller;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    isVisible = widget.isObesecure; // default to true if obscured
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: isVisible ? true : false,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: widget.icon,
          prefixIconColor: const Color.fromARGB(255, 162, 162, 162),
          suffixIcon:
              widget.isObesecure
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon:
                        isVisible
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined),
                  )
                  : null,
          filled: true,
          fillColor: Color.fromARGB(255, 243, 243, 243),
          labelText: widget.hint,
          labelStyle: TextStyle(
            fontFamily: "Poppins",
            color: const Color.fromARGB(255, 162, 162, 162),
            fontSize: 15,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }
}
