import 'package:asd/const/color.dart';
import 'package:flutter/material.dart';

void ErrorSnackBar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: colorRed,
  ));
}
