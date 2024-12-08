import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetails extends StatelessWidget {
  final String? title;
  final String? img;
  final String? pageData;
  final String author;
  final String designation;
  final String authorImg;
  BlogDetails({
    super.key,
    required this.title,
    required this.img,
    required this.pageData,
    required this.author,
    required this.designation,
    required this.authorImg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title as String,
          style: TextStyle(fontFamily: 'geb'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img!), fit: BoxFit.cover),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                      BorderSide(color: Colors.grey.shade200))),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       backgroundImage: NetworkImage(authorImg),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           author,
                  //           style: TextStyle(fontFamily: 'geb', fontSize: 16),
                  //         ),
                  //         Text(
                  //           designation,
                  //           style: TextStyle(fontFamily: 'gsb', fontSize: 10),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Text(
                  //       '27th',
                  //       style: TextStyle(fontFamily: 'geb', fontSize: 16),
                  //     ),
                  //     Text(
                  //       'September',
                  //       style: TextStyle(fontFamily: 'geb', fontSize: 10),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(bottom: 50),
              child: Html(
                data: pageData,
                style: {
                  "p": Style(
                    fontSize: FontSize(16),
                  ),
                  "ul": Style(
                    fontSize: FontSize(16),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
