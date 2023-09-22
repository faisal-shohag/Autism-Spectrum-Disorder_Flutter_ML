import 'package:asd/const/color.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  InputTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   // color: Colors.grey[200],
      // ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color2.withOpacity(0.3)),
            gapPadding: 0,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
