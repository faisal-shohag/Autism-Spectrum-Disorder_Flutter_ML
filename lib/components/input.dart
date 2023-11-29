import 'package:asd/const/color.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final VoidCallback? onTap;
  final bool readOnly;
  InputTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      required this.obscureText,
      this.onTap,
      required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   // color: Colors.grey[200],
      // ),
      child: TextField(
        onTap: onTap,
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        decoration: InputDecoration(
          // prefixText: '+88',
          // prefixStyle: TextStyle(color: Colors.black),
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
        keyboardType: keyboardType,
      ),
    );
  }
}
