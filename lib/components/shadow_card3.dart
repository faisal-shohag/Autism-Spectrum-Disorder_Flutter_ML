import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class ShadowCard3 extends StatelessWidget {
  final String title;
  
  const ShadowCard3({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      // height: 70,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 3),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 127, 127).withOpacity(0.2),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'geb',
                      fontSize: 20,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Remix.questionnaire_fill,
                            size: 15,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' Qestions',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'gsb',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Remix.time_fill,
                            size: 15,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Takes minutes',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'gsb',
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Icon(
            Remix.arrow_right_s_line,
            size: 30,
            color: Color.fromARGB(255, 206, 64, 64),
          ),
        ],
      ),
    );
  }
}
