import 'package:asd/const/color.dart';
import 'package:flutter/material.dart';
// import 'package:remixicon/remixicon.dart';

class ShowCaseCard extends StatelessWidget {
  final String? title;
  final String? val;
  final String? unit;
  final IconData icon;
  ShowCaseCard({
    super.key,
    required this.title,
    required this.val,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // gradient: LinearGradient(
        //   colors: [
        //     Color.fromARGB(255, 45, 13, 187).withOpacity(0.8),
        //     Color.fromARGB(255, 131, 103, 231).withOpacity(0.9),
        //   ],
        //   begin: Alignment.bottomLeft,
        //   end: Alignment.centerRight,
        // ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 3),
            blurRadius: 20,
            color: color2.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title as String,
                style: TextStyle(
                  fontFamily: 'geb',
                  fontSize: 18,
                ),
              ),
              Icon(icon),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                val as String,
                style: TextStyle(
                  fontFamily: 'geb',
                  fontSize: 50,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
                child: Text(
                  unit as String,
                  style: TextStyle(
                    fontFamily: 'geb',
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
