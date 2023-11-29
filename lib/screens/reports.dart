import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/clipboard.png',
            height: 300,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Diagnosis reports will be shown here!',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'gsb',
            ),
          ),
        ],
      ),
    );
  }
}
