// import 'package:asd/components/tittleText.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/screens/testScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:remixicon/remixicon.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:gap/gap.dart';

class Tests extends StatefulWidget {
  const Tests({super.key});

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  @override
  void initState() {
    super.initState();
  }

  final LocalStorage storage = LocalStorage('exam_data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          TestTop(),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Tests').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                ErrorSnackBar(context, 'Error');
                return Center(
                  child: Text('Error'),
                );
              }

              final documents = snapshot.data?.docs;
              // print(documents![0]["questions"].length);

              return FutureBuilder(
                future: storage.ready,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data != true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: documents!.length,
                        itemBuilder: (context, index) {
                          final title = documents[index]["title"];
                          int count = 0;
                          double parcent = 0;

                          final examData = storage.getItem(documents[index].id);
                          // print(examData);
                          if (examData != null) {
                            final List<dynamic> answered =
                                examData['answered'] ?? [];
                            count =
                                answered.where((number) => number == 1).length;
                            parcent = ((count /
                                    documents[index]["questions"].length) *
                                100);
                            // });
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TestScreen(
                                        title: title,
                                        examKey: documents[index].id,
                                        questions: documents[index]
                                            ['questions'],
                                        age: documents[index]["age"],
                                      )));
                            },
                            child: Column(
                              children: [
                                Gap(10),
                                TestCard(
                                  title: title,
                                  len: documents[index]["questions"].length,
                                  parcent: parcent,
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                },
              );
            },
          ),
        ],
      ),
    ));
  }
}

class TestCard extends StatelessWidget {
  final String title;
  final int len;
  final double parcent;
  const TestCard({
    super.key,
    required this.title,
    required this.len,
    required this.parcent,
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
              // Container(
              //   height: 40,
              //   width: 40,
              //   decoration: BoxDecoration(
              //     color: Colors.green.withOpacity(0.3),
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Center(
              //     child: Text(
              //       'A',
              //       style: TextStyle(
              //           fontFamily: 'geb',
              //           fontSize: 20,
              //           color: Colors.green.withOpacity(0.8)),
              //     ),
              //   ),
              // ),

              CircularPercentIndicator(
                radius: 21.0,
                lineWidth: 8.0,
                animation: true,
                percent: parcent / 100,
                animationDuration: 700,
                center: Text(
                  '${(parcent.toInt()).toString()}%',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'geb',
                  ),
                ),
                progressColor: Colors.pink,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.black,
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
                            '$len Qestions',
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
                            'Takes ${(len / 2).toString()} minutes',
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

class TestTop extends StatelessWidget {
  const TestTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 10, bottom: 10),
      margin: EdgeInsets.only(bottom: 0),
      height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 187, 13, 80).withOpacity(0.8),
            Color.fromARGB(255, 182, 26, 174).withOpacity(0.9),
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
                  'assets/images/qa.png',
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ASD Tests',
                  style: TextStyle(
                    fontFamily: 'geb',
                    color: Colors.grey.shade100,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Please note that these quizes are not a diagnosis and should not be used as a substitute for a professional evaluation. It is always best to consult with a healthcare professional who can interpret the results in the context of your specific situation and provide appropriate guidance.',
                  style: TextStyle(
                    // fontFamily: 'gsb',
                    color: Colors.grey.shade100,
                    fontSize: 13,
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
