import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData? menuIcon;
  final String? menuTitle;
  final Color? menuColor;

  const MenuItem({
    super.key,
    required this.menuIcon,
    required this.menuTitle,
    required this.menuColor,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.33,
      child: Container(
        decoration: BoxDecoration(
          color: (menuColor as Color).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: (menuColor as Color).withOpacity(0.3),
            )
          ],
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(
              (menuIcon as IconData),
              color: menuColor as Color,
            ),
            const SizedBox(height: 10),
            Text(
              menuTitle as String,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
