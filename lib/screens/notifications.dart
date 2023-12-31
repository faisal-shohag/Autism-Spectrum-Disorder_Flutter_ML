import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Remix.arrow_left_s_line,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
          child: Text(
        "No notifications yet!",
        style: TextStyle(
          fontFamily: 'geb',
          fontSize: 18,
        ),
      )),
    );
  }
}
