import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class docReports extends StatefulWidget {
  const docReports({super.key});

  @override
  State<docReports> createState() => _docReportsState();
}

class _docReportsState extends State<docReports> {
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
          'Reports',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Text('Reports from your doctor will appear here!'),
    );
  }
}
