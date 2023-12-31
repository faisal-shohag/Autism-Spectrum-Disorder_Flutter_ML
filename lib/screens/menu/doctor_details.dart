import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';
import 'package:glassmorphism/glassmorphism.dart';

class DoctorDetails extends StatefulWidget {
  final String tag;
  final String imageUrl;
  final String name;
  final String details;
  final dynamic rating;
  final String speciality;
  final String location;
  final String degree;
  const DoctorDetails({
    super.key,
    required this.tag,
    required this.imageUrl,
    required this.name,
    required this.details,
    required this.location,
    required this.rating,
    required this.speciality,
    required this.degree,
  });

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gap(30),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
                    Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
              ),
              // color: Colors.red,
              child: Stack(
                children: [
                  GlassmorphicContainer(
                    margin: EdgeInsets.only(bottom: 0),
                    borderRadius: 20,
                    blur: 5,
                    border: 5,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.1),
                        Color(0xFFFFFFFF).withOpacity(0.05),
                      ],
                      stops: [0.1, 1],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.5),
                        Color(0xFFFFFFFF).withOpacity(0.5),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 50, left: 20),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(10, 10),
                                  blurRadius: 20,
                                  color: Color.fromARGB(68, 17, 17, 17),
                                ),
                              ],
                            ),
                            child: Icon(Remix.arrow_left_s_line),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Hero(
                                tag: widget.tag,
                                child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  height: 180,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    // color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(widget.imageUrl),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  color: Colors.grey.shade100,
                                  fontSize: 30,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.degree,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'gsb',
                                ),
                              ),
                              Text(
                                widget.speciality,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'gsb',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RatingBar.builder(
                                  allowHalfRating: true,
                                  glow: true,
                                  ignoreGestures: true,
                                  glowRadius: 10,
                                  glowColor: Color.fromARGB(255, 94, 44, 173),
                                  itemSize: 15,
                                  initialRating: widget.rating,
                                  itemBuilder: (context, _) => Icon(
                                        Remix.star_fill,
                                        color:
                                            Color.fromARGB(255, 243, 241, 240),
                                      ),
                                  onRatingUpdate: (rating) {}),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(Remix.phone_fill),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(Remix.whatsapp_fill),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(Remix.mail_send_fill),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'About',
              style: TextStyle(
                fontFamily: 'geb',
                fontSize: 23,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                widget.details,
                style: TextStyle(
                  // fontFamily: 'gsb',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 4),
              blurRadius: 20,
              color: Color.fromARGB(255, 78, 77, 77).withOpacity(0.2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 93, 38, 196),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            'Send Request!',
            style: TextStyle(
              fontFamily: 'geb',
              fontSize: 18,
              color: Colors.grey.shade100,
            ),
          ),
        ),
      ),
    );
  }
}

class TopDoctor extends StatelessWidget {
  const TopDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 10, bottom: 10),
      margin: EdgeInsets.only(bottom: 0),
      // height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
            Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 20,
                    color: Color.fromARGB(68, 17, 17, 17),
                  ),
                ],
              ),
              child: Icon(Remix.arrow_left_s_line),
            ),
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/doctors.png',
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Doctors',
                  style: TextStyle(
                    fontFamily: 'geb',
                    color: Colors.grey.shade100,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
