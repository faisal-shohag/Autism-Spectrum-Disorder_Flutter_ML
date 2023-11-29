import 'package:flutter/material.dart';

class MenuTtitle extends StatelessWidget {
  final String? title;
  MenuTtitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title as String,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade600,
          fontFamily: 'geb',
        ),
      ),
    );
  }
}
