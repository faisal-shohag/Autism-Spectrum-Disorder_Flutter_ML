import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? img;
  ProfileListItem({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          img as String,
          height: 25,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title as String,
              style: TextStyle(fontSize: 18, fontFamily: 'geb'),
            ),
            Text(
              subTitle as String,
              style: TextStyle(fontSize: 10, fontFamily: 'geb'),
            ),
          ],
        ),
      ],
    );
  }
}
