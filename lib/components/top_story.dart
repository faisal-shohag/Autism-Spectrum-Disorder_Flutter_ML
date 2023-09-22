import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TopStory extends StatelessWidget {
  final String? title;
  final String? readTime;
  final String? bgImage;
  TopStory({
    super.key,
    @required this.title,
    @required this.readTime,
    this.bgImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: (bgImage != null)
            ? DecorationImage(
                image: AssetImage(bgImage.toString()),
                alignment: Alignment.centerRight,
                opacity: 0.3,
              )
            : null,
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 45, 13, 187).withOpacity(0.8),
            Color.fromARGB(255, 131, 103, 231).withOpacity(0.9),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(80),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 10),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.2),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          top: 25,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top story',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                title.toString(),
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Remix.time_line,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      readTime.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(4, 8),
                        blurRadius: 10,
                        color: Color.fromARGB(255, 45, 13, 187),
                      ),
                    ],
                  ),
                  child: Icon(
                    Remix.arrow_right_s_line,
                    size: 30,
                  ),
                )
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 400.ms)
                    .scale(duration: 400.ms),
              ],
            )
          ],
        ),
      ),
    );
  }
}
