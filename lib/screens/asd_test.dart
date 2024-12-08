import "package:asd/const/functions.dart";
import "package:asd/screens/image_diag.dart";
// import "package:asd/screens/menu/doctor.dart";
import 'package:awesome_dialog/awesome_dialog.dart';
import "package:asd/screens/q_test.dart";
import "package:asd/services/userinfo.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:dotted_line/dotted_line.dart';
import "package:flutter_animate/flutter_animate.dart";
import "package:gap/gap.dart";
import "package:remixicon/remixicon.dart";

class ASDTEST extends StatefulWidget {
  const ASDTEST({super.key});

  @override
  State<ASDTEST> createState() => _ASDTESTState();
}

class _ASDTESTState extends State<ASDTEST> {
  Map<String, dynamic>? data;
  Age? age;

  String title = 'MCHAT-R TEST';
  var q_data;
  int status = 0;
  var uid = FirebaseAuth.instance.currentUser!.uid;
  // void getUser() async {
  //   data = await UserData()
  //       .getDataFromFirestore(FirebaseAuth.instance.currentUser!.uid);
  //  // print(data!["childAge"]);
  //   if (!mounted) return;
  //   // setState(() {
  //   age = CalculateAge(data!['childAge']);

  //   // });
  // }

  // Future<void> addDoc() async {
  //   try {
  //     var data = await rootBundle.loadString('assets/json/cast.json');
  //     var mapData = jsonDecode(data);
  //     await FirebaseFirestore.instance
  //         .collection('Tests2')
  //         .add({"questions": mapData});
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  String examKey = "lnTtqGyJVexD2TFjngnB";
  Future<String> loadData() async {
    data = await UserData()
        .getDataFromFirestore(FirebaseAuth.instance.currentUser!.uid);
    age = CalculateAge(data!['childAge']);
    if (age!.years > 3) {
      setState(() {
        title = 'CAST TEST';
        examKey = "LLYpcEdg0tUTYdAGnRdW";
      });
    }
    // print(title);
    // print(examKey);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('Tests2')
            .doc(examKey)
            .get();
    if (documentSnapshot.exists) {
      q_data = documentSnapshot.data()!;
      Map<String, dynamic> users = q_data['users'];
      if (users[uid] != null && !users[uid]["userScores"].isEmpty) {
        setState(() {
          status = 1;
        });
      } else {
        status = 0;
      }
    } else {
      print('Doc not found!');
    }
    return "success";
  }

  @override
  void initState() {
    // getUser();
    loadData();
    // addDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // margin: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white60,
            boxShadow: [
              BoxShadow(
                offset: Offset(-1, -5),
                blurRadius: 20,
                color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-1, -5),
                      blurRadius: 20,
                      color:
                          Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/puzzle-solving-question-mark-background-guidance-support_1017-43014.jpg'),
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Gap(20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: [
                          Gap(20),
                          Text(
                            'Questionnaire Test',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'geb',
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Begin with answering some interactive questions.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'gsb',
                              fontSize: 10,
                            ),
                          ),
                          Gap(10),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (status == 0) {
                                AwesomeDialog(
                                  context: context,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.noHeader,
                                  title: '$title',
                                  titleTextStyle: TextStyle(
                                    fontFamily: 'geb',
                                    fontSize: 18,
                                  ),
                                  descTextStyle: TextStyle(fontSize: 17),
                                  desc:
                                      'Based on your age(${age!.years} years ${age!.months} months ${age!.days} days), we recommend ${title}.',
                                  btnOkOnPress: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => QATest(
                                          title: title,
                                          age: age!,
                                          examKey: examKey,
                                          questions: q_data["questions"],
                                        ),
                                      ),
                                    );
                                  },
                                  btnOkIcon: Remix.checkbox_circle_fill,
                                  btnOkText: 'Start test!',
                                ).show();
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => QATest(
                                      title: title,
                                      age: age!,
                                      examKey: examKey,
                                      questions: q_data["questions"],
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            icon: Icon(
                              Remix.arrow_right_s_line,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Begin!',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'geb',
                              ),
                            ),
                          )
                              .animate(delay: 100.ms)
                              .fadeIn(duration: 500.ms)
                              .slideX(
                                duration: 500.ms,
                                begin: -0.3,
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                lineLength: 60,
                lineThickness: 2.0,
                dashLength: 4.0,
                dashColor: Colors.black54,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-1, -5),
                      blurRadius: 20,
                      color:
                          Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://media.licdn.com/dms/image/D5612AQE7s66UIkVuJg/article-cover_image-shrink_720_1280/0/1692163288530?e=2147483647&v=beta&t=LMfClWdJ5p62mGdaJAX6aEhfxAMiG6Bj5n53ZP12dRk'),
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                    Gap(20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: [
                          Gap(20),
                          Text(
                            'AI Test',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'geb',
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Test with our well trained machine learning model by uploading photo.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'gsb',
                              fontSize: 10,
                            ),
                          ),
                          Gap(10),
                          ElevatedButton.icon(
                            onPressed: () {
                              // if (status == 1) {
                              //   AwesomeDialog(
                              //           context: context,
                              //           dialogType: DialogType.noHeader,
                              //           headerAnimationLoop: false,
                              //           animType: AnimType.bottomSlide,
                              //           title: 'Incomplete Step!',
                              //           desc:
                              //               'Please complete the Q/A test first then move to the Machine Learning based test!',
                              //           buttonsTextStyle: const TextStyle(
                              //               color: Colors.black),
                              //           showCloseIcon: false,
                              //           btnOkText: "OK",
                              //           btnOkOnPress: () {})
                              //       .show();
                              // } else if (status == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ImageDiagnosis()));
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            icon: Icon(
                              Remix.arrow_right_s_line,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Start Now!',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'geb',
                              ),
                            ),
                          )
                              .animate(delay: 150.ms)
                              .fadeIn(duration: 500.ms)
                              .slideX(
                                duration: 500.ms,
                                begin: -0.3,
                              ),
                          // Gap(5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                lineLength: 60,
                lineThickness: 2.0,
                dashLength: 4.0,
                dashColor: Colors.black54,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),

              // ElevatedButton.icon(
              //   onPressed: () {
              //     // if (status == 1) {
              //     AwesomeDialog(
              //             context: context,
              //             dialogType: DialogType.noHeader,
              //             headerAnimationLoop: false,
              //             animType: AnimType.bottomSlide,
              //             title: 'Aww!!',
              //             desc: 'Result is not ready yet!',
              //             buttonsTextStyle:
              //                 const TextStyle(color: Colors.black),
              //             showCloseIcon: false,
              //             btnOkText: "OK",
              //             btnOkOnPress: () {})
              //         .show();
              //     // } else if (status == 0) {
              //     // Navigator.of(context).push(MaterialPageRoute(
              //     //     builder: (context) => ImageDiagnosis()));
              //     // }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color.fromARGB(255, 236, 64, 30),
              //     textStyle: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              //   icon: Icon(
              //     Remix.arrow_right_s_line,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     'See the overall Result',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontFamily: 'geb',
              //     ),
              //   ),
              // ).animate(delay: 150.ms).fadeIn(duration: 500.ms).slideX(
              //       duration: 500.ms,
              //       begin: -0.3,
              //     ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.2,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         offset: Offset(-1, -5),
              //         blurRadius: 20,
              //         color:
              //             Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 100,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(30),
              //             bottomRight: Radius.circular(30),
              //             topLeft: Radius.circular(10),
              //             bottomLeft: Radius.circular(10),
              //           ),
              //           image: DecorationImage(
              //             image: AssetImage('assets/images/d3.jpg'),
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //       Gap(20),
              //       Container(
              //         width: MediaQuery.of(context).size.width * 0.6,
              //         child: Column(
              //           children: [
              //             Gap(20),
              //             Text(
              //               'Expert Test',
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(
              //                 fontFamily: 'geb',
              //                 fontSize: 20,
              //               ),
              //             ),
              //             Text(
              //               'We suggest an expert\'s concern for further test based on the test result.(If needed)',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 fontFamily: 'gsb',
              //                 fontSize: 10,
              //               ),
              //             ),
              //             Gap(10),
              //             ElevatedButton.icon(
              //               onPressed: () {
              //                 Navigator.of(context).push(MaterialPageRoute(
              //                     builder: (context) => AssignedDoctor()));
              //               },
              //               style: ElevatedButton.styleFrom(
              //                 backgroundColor: Colors.green,
              //                 textStyle: TextStyle(
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               icon: Icon(
              //                 Remix.arrow_right_s_line,
              //                 color: Colors.white,
              //               ),
              //               label: Text(
              //                 'Appoint!',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontFamily: 'geb',
              //                 ),
              //               ),
              //             )
              //                 .animate(delay: 200.ms)
              //                 .fadeIn(duration: 500.ms)
              //                 .slideX(
              //                   duration: 500.ms,
              //                   begin: -0.3,
              //                 ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
