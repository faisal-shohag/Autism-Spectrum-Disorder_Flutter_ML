import 'package:flutter/material.dart';

class ShowCaseSmall extends StatelessWidget {
  final String? val;
  final String? title;
  final Color? color;
  ShowCaseSmall({
    super.key,
    required this.val,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      height: 70,
      width: 95,
      decoration: BoxDecoration(
        color: (color as Color).withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            val as String,
            style: TextStyle(
              fontFamily: 'geb',
              fontSize: 25,
              color: color as Color,
            ),
          ),
          Text(
            title as String,
            style: TextStyle(
              fontFamily: 'geb',
              fontSize: 15,
              color: color as Color,
            ),
          ),
        ],
      ),
    );
  }
}
