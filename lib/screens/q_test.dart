// import 'dart:convert';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/functions.dart';
import 'package:asd/models/myData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_html/flutter_html.dart';

List<dynamic>? usersAns;
List<dynamic>? userScores;

class QATest extends StatefulWidget {
  final String title;
  final Age age;
  final List<dynamic> questions;
  final String examKey;
  const QATest({
    super.key,
    required this.title,
    required this.age,
    required this.questions,
    required this.examKey,
  });

  @override
  State<QATest> createState() => _QATestState();
}

class _QATestState extends State<QATest> {
  PageController _controller = PageController(initialPage: 0);
  final user = FirebaseAuth.instance.currentUser!;
  bool popScope = false;

  void generateEmpty() {
    usersAns = List.generate(widget.questions.length, (index) => -1);
    userScores = List.generate(widget.questions.length, (index) => 0);
  }

  @override
  void initState() {
    super.initState();
    generateEmpty();
    print(widget.examKey);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PopScope(
          canPop: popScope,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              animType: AnimType.rightSlide,
              headerAnimationLoop: true,
              title: 'Go Back',
              desc: 'Do you want to go back?',
              btnOkOnPress: () {
                Provider.of<CounterNotifier>(context, listen: false)
                    .updateCount(1);
                Navigator.of(context).pop(true);
              },
            ).show();
          },
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 187, 13, 80).withOpacity(0.8),
                      Color.fromARGB(255, 182, 26, 174).withOpacity(0.9),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      blurRadius: 20,
                      color:
                          Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: true,
                          title: 'Go Back',
                          desc: 'Do you want to go back?',
                          btnOkOnPress: () {
                            Provider.of<CounterNotifier>(context, listen: false)
                                .updateCount(1);
                            Navigator.of(context).pop(true);
                          },
                        ).show();
                      },
                      child: Icon(
                        Remix.arrow_left_s_line,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: 'geb',
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'For Age ${widget.age.years} Years ${widget.age.months} Months ${widget.age.days} Days',
                          style: TextStyle(
                            fontFamily: 'gsb',
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                        child: Icon(
                          Remix.more_2_fill,
                          size: 20,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 2,
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  headerAnimationLoop: false,
                                  animType: AnimType.topSlide,
                                  showCloseIcon: true,
                                  closeIcon: const Icon(
                                      Icons.close_fullscreen_outlined),
                                  title: 'Reset',
                                  desc: 'Do you want reset the TEST?',
                                  btnCancelOnPress: () {},
                                  onDismissCallback: (type) {
                                    debugPrint(
                                        'Dialog Dismiss from callback $type');
                                  },
                                  btnOkOnPress: () async {
                                    DocumentReference<Map<String, dynamic>>
                                        documentReference = FirebaseFirestore
                                            .instance
                                            .collection('Tests2')
                                            .doc(widget.examKey);
                                    var uid =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    await documentReference.update({
                                      "users": {
                                        uid: {
                                          "userScores": [],
                                          "scoreSum": 0,
                                        }
                                      }
                                    });
                                  },
                                ).show();
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Remix.refresh_line),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Reset Test',
                                    style: TextStyle(
                                      fontFamily: 'gsb',
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Remix.information_line),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'About',
                                    style: TextStyle(
                                      fontFamily: 'gsb',
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ];
                        }),
                  ],
                ),
              ),
              Gap(30),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Tests2')
                      .doc(widget.examKey)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error'),
                      );
                    }
                    Map<String, dynamic> users = snapshot.data['users'];

                    // print(threshold[thresIndex]);
                    if (users[user.uid] != null &&
                        !users[user.uid]["userScores"].isEmpty) {
                      int score = users[user.uid]["scoreSum"];
                      List<dynamic> threshold = snapshot.data["threshold"];
                      int thresIndex = 0;
                      for (int i = 0; i < threshold.length; i++) {
                        if (score <= threshold[i]["value"]) {
                          thresIndex = i;
                          break;
                        }
                      }
                      // print(score);

                      return Column(
                        children: [
                          Text(
                            'Score',
                            style: TextStyle(fontFamily: 'gsb', fontSize: 25),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 187, 13, 80)
                                      .withOpacity(0.8),
                                  Color.fromARGB(255, 182, 26, 174)
                                      .withOpacity(0.9),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${users[user.uid]["scoreSum"]}',
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  fontSize: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Gap(20),
                          Text(
                            'Risk: ${threshold[thresIndex]["risk"]}',
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'geb',
                            ),
                          ),
                          Gap(5),
                          Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Html(
                              data: '${threshold[thresIndex]["details"]}',
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Container(
                          child: Consumer<CounterNotifier>(
                            builder: (context, counterNotifier, child) {
                              return Text(
                                '${counterNotifier.counter}/${widget.questions.length}',
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  fontSize: 20,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 250,
                          child: PageView.builder(
                            // allowImplicitScrolling: true,
                            physics: NeverScrollableScrollPhysics(),
                            pageSnapping: true,
                            controller: _controller,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.questions.length,
                            itemBuilder: (context, index) {
                              return QuestionPage(
                                examKey: widget.examKey,
                                controller: _controller,
                                qIndex: index,
                                length: widget.questions.length,
                                options: widget.questions[index]['options'],
                                question: widget.questions[index]['q'],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {
  final List<dynamic> options;
  final int length;
  final String question;
  final PageController controller;
  final int qIndex;
  final String examKey;
  const QuestionPage({
    super.key,
    required this.controller,
    required this.length,
    required this.qIndex,
    required this.options,
    required this.question,
    required this.examKey,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  void NextPage() {
    if (usersAns![widget.qIndex] == -1) {
      WarningSnackBar(context, 'Please answer this first!');
    } else {
      widget.controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      // print("Next: ${widget.qIndex + 2}");
      Provider.of<CounterNotifier>(context, listen: false)
          .updateCount(widget.qIndex + 2);
    }
  }

  void PreviousPage() {
    widget.controller.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    // print("Prev: ${widget.qIndex + 1}");
    Provider.of<CounterNotifier>(context, listen: false)
        .updateCount(widget.qIndex == 0 ? 1 : widget.qIndex);
  }

  void Submit() async {
    print("Submit");
    if (usersAns![widget.qIndex] == -1) {
      WarningSnackBar(context, 'Please answer this first!');
    } else {
      num sum = 0;
      for (int i = 0; i < userScores!.length; i++) {
        sum += userScores?[i];
      }
      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance.collection('Tests2').doc(widget.examKey);
      var uid = FirebaseAuth.instance.currentUser!.uid;
      await documentReference.update({
        "users": {
          uid: {
            "userScores": userScores,
            "scoreSum": sum,
          }
        }
      });
    }
  }

  bool hasDuplicateValues(List<dynamic> options) {
    List<dynamic> values = options.map((option) => option["value"]).toList();

    for (int i = 0; i < values.length; i++) {
      if (values.sublist(i + 1).contains(values[i])) {
        return true;
      }
    }
    return false;
  }

  List<dynamic> options = [];

  @override
  void initState() {
    setState(() {
      if (hasDuplicateValues(widget.options)) {
        // print('Duplicate');
        options = [
          {
            "title": "Yes",
            "value": -2,
          },
          {
            "title": "No",
            "value": 0,
          },
        ];
      } else {
        options = widget.options;
      }
      // print(options);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.question,
            style: TextStyle(
              fontFamily: 'geb',
              fontSize: 19,
              // fontWeight: FontWeight.bold,
            ),
          ),
          CustomRadioButton(
            elevation: 0,
            unSelectedColor: Colors.grey.shade200,
            selectedBorderColor: Colors.white,
            unSelectedBorderColor: Colors.white,
            height: 40,
            shapeRadius: 10,
            horizontal: true,
            buttonLables:
                widget.options.map((item) => item["title"].toString()).toList(),
            buttonValues: hasDuplicateValues(widget.options)
                ? [-2, 0]
                : widget.options.map((item) => item["value"]).toList(),
            defaultSelected: usersAns![widget.qIndex] == -1
                ? null
                : usersAns![widget.qIndex],
            buttonTextStyle: ButtonTextStyle(
              selectedColor: Colors.white,
              unSelectedColor: Colors.black,
              textStyle: TextStyle(fontSize: 18),
            ),
            radioButtonValue: (value) {
              if (value == -2) {
                usersAns![widget.qIndex] = 0;
                userScores![widget.qIndex] = 0;
              } else {
                usersAns![widget.qIndex] = value;
                userScores![widget.qIndex] = value;
              }

              // print(value);
            },
            selectedColor: Colors.redAccent,
          ),
          Gap(20),
          if (widget.qIndex != widget.length - 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: PreviousPage,
                  child: GradientButton(
                    icon: Remix.arrow_left_line,
                    btnText: 'Previous',
                    left: false,
                  ),
                ),
                Gap(30),
                InkWell(
                  onTap: NextPage,
                  child: GradientButton(
                    icon: Remix.arrow_right_line,
                    btnText: 'Next',
                    left: true,
                  ),
                ),
              ],
            ),
          if (widget.qIndex == widget.length - 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: PreviousPage,
                  child: GradientButton(
                    icon: Remix.arrow_left_line,
                    btnText: 'Previous',
                    left: false,
                  ),
                ),
                Gap(30),
                GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: true,
                      title: 'Submit Test',
                      desc: 'Do you want to submit the TEST?',
                      btnOkOnPress: Submit,
                    ).show();
                  },
                  child: GradientButton(
                    icon: Remix.check_line,
                    btnText: 'Submit',
                    left: false,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String btnText;
  final bool left;
  final IconData icon;
  const GradientButton({
    super.key,
    required this.btnText,
    required this.left,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 187, 13, 80).withOpacity(0.8),
            Color.fromARGB(255, 182, 26, 174).withOpacity(0.9),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 4),
            blurRadius: 20,
            color: Color.fromARGB(255, 78, 77, 77).withOpacity(0.5),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!left)
              Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            if (!left) Gap(10),
            Text(
              btnText,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'gsb',
                fontSize: 16,
              ),
            ),
            if (left) Gap(10),
            if (left)
              Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
