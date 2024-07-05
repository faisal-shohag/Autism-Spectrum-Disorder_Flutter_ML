import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IconMenuItem extends StatelessWidget {
  final String imageURL;
  final String title;
  const IconMenuItem({
    super.key,
    required this.imageURL,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 45,
          child: Image.network(imageURL),
        ),
        Gap(5),
        Text(
          title,
          style: TextStyle(fontFamily: 'geb'),
        )
      ],
    );
  }
}
