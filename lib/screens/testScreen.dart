import 'package:asd/components/snackBars.dart';
import 'package:asd/const/functions.dart';
import 'package:asd/screens/tests.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';

List<dynamic> userAns = [];
List<dynamic> answered = [];
List<dynamic> userAnsVal = [];
var examData;

class ExamData {
  final String examKey;

  ExamData(this.examKey);

  // Save the data for the exam
  Future<void> saveData(LocalStorage storage, List<dynamic> userAns,
      List<dynamic> answered, List<dynamic> userAnsVal) async {
    final data = {
      'userAns': userAns,
      'answered': answered,
      'userAnsVal': userAnsVal,
    };
    await storage.setItem(examKey, data);
  }

  // Retrieve the data for the exam
  Map<String, dynamic> retrieveData(LocalStorage storage) {
    final data = storage.getItem(examKey);
    return data != null ? data : {};
  }
}

LocalStorage storage = LocalStorage('exam_data');

class TestScreen extends StatefulWidget {
  final String? title;
  final String? examKey;
  final List<dynamic> questions;
  final String age;
  const TestScreen({
    super.key,
    required this.title,
    required this.examKey,
    required this.questions,
    required this.age,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  PageController _controller = PageController(initialPage: 0);
  final user = FirebaseAuth.instance.currentUser!;

  String? submitStatus;

  void handleSubmit() {
    final docRef =
        FirebaseFirestore.instance.collection('Tests').doc(widget.examKey);
    docRef.update({
      'users': {
        user.uid: {
          'name': user.displayName,
          'userAns': userAns,
          'userAnsVal': userAnsVal,
          'answered': answered,
        }
      }
    }).then((value) {
      // SuccessSnackBar(context, 'Successfully Submitted!');
    }).catchError((error) {
      print(error);
      // ErrorSnackBar(context, 'Error while submitting...');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          showConfirmationDialog(context);
        },
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Tests')
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
            if (users[user.uid] != null &&
                !users[user.uid]['userAns'].isEmpty) {
              List<dynamic> myAns = users[user.uid]["userAns"];
              List<dynamic> myVal = users[user.uid]["userAnsVal"];
              num threshold = snapshot.data["threshold"];
              num res = 0;
              for (int i = 0; i < myVal.length; i++) {
                res += myVal[i];
              }
              // print(res);
              return Column(
                children: [
                  TestScreenTop(
                    widget: widget,
                    age: widget.age,
                    examKey: widget.examKey!,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: 20, top: 0, left: 20, right: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
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
                                  res.toString(),
                                  style: TextStyle(
                                    fontFamily: 'geb',
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/happy.png',
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    (res > threshold)
                                        ? 'You might have autism!'
                                        : 'You may not be autistic!',
                                    style: TextStyle(
                                        fontFamily: 'gsb', fontSize: 20.0),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Text(
                              'Your Response',
                              style: TextStyle(fontFamily: 'geb', fontSize: 20),
                            ),
                            for (int index = 0;
                                index < widget.questions.length;
                                index++)
                              JustQuestion(
                                index: index,
                                ansIndex: myAns[index],
                                question: widget.questions[index]['q'],
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }

            return FutureBuilder(
                future: storage.ready,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data != true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  examData = ExamData(widget.examKey!);
                  final savedData = examData.retrieveData(storage);

                  userAns = savedData['userAns'] ??
                      List.generate(widget.questions.length, (index) => 0);
                  answered = savedData['answered'] ??
                      List.generate(widget.questions.length, (index) => 0);
                  userAnsVal = savedData['userAnsVal'] ??
                      List.generate(widget.questions.length, (index) => 0);

                  return Column(
                    children: [
                      TestScreenTop(
                        widget: widget,
                        age: widget.age,
                        examKey: widget.examKey!,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: PageView.builder(
                          // allowImplicitScrolling: true,
                          physics: NeverScrollableScrollPhysics(),
                          pageSnapping: true,
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.questions.length,
                          itemBuilder: (context, index) {
                            return QuestionCard(
                              controller: _controller,
                              qIndex: index,
                              length: widget.questions.length,
                              options: widget.questions[index]['Options'],
                              question: widget.questions[index]['q'],
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final countAns =
                              answered.where((number) => number == 1).length;
                          if (countAns == widget.questions.length) {
                            showCustomDialog(context, 'Submit?',
                                'Do you want to submit and see result?', () {
                              handleSubmit();
                              Navigator.of(context).pop();
                            });
                          } else {
                            ErrorSnackBar(
                                context, 'Answare all the questions first!');
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
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
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 4),
                                blurRadius: 20,
                                color: Color.fromARGB(255, 78, 77, 77)
                                    .withOpacity(0.5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'gsb',
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Remix.arrow_right_line,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}

Future<bool> showConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm',
          style: TextStyle(fontFamily: 'geb'),
        ),
        content: Text('Are you want to go back?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Tests()));
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

class JustQuestion extends StatelessWidget {
  final int index;
  final int ansIndex;
  final String question;
  const JustQuestion(
      {super.key,
      required this.ansIndex,
      required this.question,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${question}',
            style: TextStyle(fontSize: 20, fontFamily: 'geb'),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ansIndex == 1 ? Colors.red : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Definitely Agree',
                style: TextStyle(fontFamily: 'gsb', fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ansIndex == 2 ? Colors.red : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Slightly Agree',
                style: TextStyle(fontFamily: 'gsb', fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ansIndex == 3 ? Colors.red : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Slightly Disagree',
                style: TextStyle(fontFamily: 'gsb', fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ansIndex == 4 ? Colors.red : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Definitely Disagree',
                style: TextStyle(fontFamily: 'gsb', fontSize: 18),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final List<dynamic> options;
  final int length;
  final String question;
  final PageController controller;
  final int qIndex;
  const QuestionCard({
    super.key,
    required this.controller,
    required this.qIndex,
    required this.question,
    required this.length,
    required this.options,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<Color> colors = [
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
    Colors.grey.shade200,
  ];
  int? _curr;

  void NextPage() {
    if (answered[widget.qIndex] == 1) {
      widget.controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      WarningSnackBar(context, 'Please answer this question first!');
    }
  }

  void PreviousPage() {
    widget.controller.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void optionClick(int index, int val) {
    widget.controller
        .nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    // widget.incrementCount();
    // print(index);
    userAns[widget.qIndex] = index + 1;
    answered[widget.qIndex] = 1;
    userAnsVal[widget.qIndex] = val;

    setState(() {
      _curr = widget.qIndex + 1;
      colors[userAns[widget.qIndex]] = Colors.red;
      for (int i = 1; i < colors.length; i++) {
        if (i != userAns[widget.qIndex]) {
          colors[i] = Colors.grey.shade200;
        }
      }
    });

    // print(userAns);
    storage.ready.then((_) {
      examData.saveData(storage, userAns, answered, userAnsVal);
    });
  }

  @override
  void initState() {
    // if (userAns.length != widget.length) {
    //   userAns = List.generate(widget.length, (index) => 0);
    //   answered = List.generate(widget.length, (index) => 0);
    //   userAnsVal = List.generate(widget.length, (index) => 0);
    //   examData.saveData(storage, userAns, answered, userAnsVal);
    // }
    // storage.ready.then((_) {
    // print(userAns);
    setState(() {
      colors[userAns[widget.qIndex]] = Colors.red;
    });
    // });

    _curr = widget.qIndex + 1;
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.only(top: 40),
      // height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_curr}',
                  style: TextStyle(
                    // color: Colors.white,
                    fontFamily: 'geb',
                    fontSize: 20,
                  ),
                ),
                Text(
                  '/${widget.length}',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontFamily: 'gsb',
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${widget.question}',
            style: TextStyle(fontSize: 20, fontFamily: 'geb'),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              optionClick(0, widget.options[0]);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors[1],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Definitely Agree',
                  style: TextStyle(fontFamily: 'gsb', fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              optionClick(1, widget.options[1]);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors[2],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Slightly Agree',
                  style: TextStyle(fontFamily: 'gsb', fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              optionClick(2, widget.options[2]);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors[3],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Slightly Disagree',
                  style: TextStyle(fontFamily: 'gsb', fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              optionClick(3, widget.options[3]);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors[4],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Definitely Disagree',
                  style: TextStyle(fontFamily: 'gsb', fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: PreviousPage,
                child: Container(
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
                        Icon(
                          Remix.arrow_left_line,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Previous',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'gsb',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              (answered[widget.qIndex] == 1)
                  ? GestureDetector(
                      onTap: NextPage,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 187, 13, 80).withOpacity(0.8),
                              Color.fromARGB(255, 182, 26, 174)
                                  .withOpacity(0.9),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              blurRadius: 20,
                              color: Color.fromARGB(255, 78, 77, 77)
                                  .withOpacity(0.5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'gsb',
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Remix.arrow_right_line,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: NextPage,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 196, 144, 164)
                                  .withOpacity(0.8),
                              Color.fromARGB(46, 112, 87, 111).withOpacity(0.9),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              blurRadius: 20,
                              color: Color.fromARGB(255, 78, 77, 77)
                                  .withOpacity(0.5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'gsb',
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Remix.arrow_right_line,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
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

class TestScreenTop extends StatelessWidget {
  final String age;
  final String examKey;
  const TestScreenTop({
    super.key,
    required this.widget,
    required this.age,
    required this.examKey,
  });

  final TestScreen widget;

  void ResetSubmit() {
    final user = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection('Tests').doc(widget.examKey);
    docRef.update({
      'users': {
        user!.uid: {
          'name': user.displayName,
          'userAns': [],
          'userAnsVal': [],
          'answered': [],
        }
      }
    }).then((value) {
      // SuccessSnackBar(context, 'Successfully Reset!');
    }).catchError((error) {
      print(error);
      // ErrorSnackBar(context, 'Error while Resetting...');
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Reset this Test?',
              style: TextStyle(fontFamily: 'geb'),
            ),
            content: Text('Your data for this test will be deleted!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  storage.deleteItem(examKey);
                  ResetSubmit();
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Tests()));
                  SuccessSnackBar(context,
                      'Test has been Reset Successfully! Reopen the exam to see effect!');
                },
                child: Text('Reset'),
              ),
            ],
          );
        });
  }

  void showBackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm',
            style: TextStyle(fontFamily: 'geb'),
          ),
          content: Text('Are you want to go back?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Do not exit
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Tests()));
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showBackDialog(context);
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
                widget.title!,
                style: TextStyle(
                  fontFamily: 'geb',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                'Age ${age}',
                style: TextStyle(
                  fontFamily: 'gsb',
                  color: Colors.white,
                  fontSize: 14,
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
                      _showDialog(context);
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
    );
  }
}
