import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
// import 'package:flutter_animate/flutter_animate.dart';

class ShadowItemCard extends StatelessWidget {
  final String? cardImage;
  final String? title;
  final String? subTitle;
  final String? cornerImage;

  ShadowItemCard({
    super.key,
    required this.cardImage,
    @required this.title,
    @required this.subTitle,
    this.cornerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        image: (cornerImage != null)
            ? DecorationImage(
                image: AssetImage(cornerImage.toString()),
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight)
            : null,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, -5),
            blurRadius: 40,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            cardImage.toString(),
            height: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  subTitle.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: Column()),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(-1, -5),
                    blurRadius: 40,
                    color: Color.fromARGB(255, 131, 103, 231).withOpacity(1),
                  ),
                ]),
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(2),
            child: Icon(Remix.arrow_right_s_line),
          )
        ],
      ),
    );
  }
}
