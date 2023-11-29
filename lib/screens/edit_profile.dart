import 'package:asd/components/button.dart';
import 'package:asd/components/input.dart';
import 'package:asd/components/menutitle.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/RegEx.dart';
import 'package:asd/const/color.dart';
import 'package:asd/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoEdit extends StatefulWidget {
  const InfoEdit({super.key});

  @override
  State<InfoEdit> createState() => _InfoEditState();
}

class _InfoEditState extends State<InfoEdit> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController guardian = TextEditingController();
  TextEditingController displayName = TextEditingController();
  TextEditingController relationWith = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController childGrade = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController gender = TextEditingController();

  bool checkVal = false;
  bool isClick = false;

  var user = FirebaseAuth.instance.currentUser;
  Future addData(
    uid,
    email,
    guardianName,
    relationWith,
    dateOfBirth,
    childGrade,
    photoUrl,
    displayName,
    phoneNumber,
    height,
    weight,
    gender,
  ) async {
    var data = UserClass(
      uid: uid,
      email: email,
      guardianName: guardianName,
      relationWith: relationWith,
      childAge: dateOfBirth,
      childGrade: childGrade,
      photoUrl: photoUrl,
      displayName: displayName,
      phoneNumber: phoneNumber,
      height: height,
      weight: weight,
      gender: gender,
      info: true,
    );
    FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(data.toJson());

      setState(() {
        isClick = false;
      });
      Navigator.of(context).pop();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Profile()));
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      setState(() {
        isClick = false;
      });
    }
  }

  String formCheck() {
    if (!phoneRegx.hasMatch(phoneNumber.text)) {
      return "Invalid Phone Number!";
    }
    if (!emailRegx.hasMatch(email.text)) {
      return "Invalid email!";
    }
    if (email.text.trim() == "" ||
        guardian.text.trim() == "" ||
        relationWith.text.trim() == "" ||
        dateOfBirth.text.trim() == "" ||
        displayName.text.trim() == "" ||
        phoneNumber.text.trim() == "" ||
        childGrade.text.trim() == "" ||
        gender.text.trim() == "") {
      return "Please fill all the field!";
    }
    return "";
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
    checkVal = false;
    isClick = false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            ErrorSnackBar(context, snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }
          DocumentSnapshot<Map<String, dynamic>> userData = snapshot.data!;
          email.text = userData["email"];
          guardian.text = userData["guardianName"];
          displayName.text = userData["displayName"];
          relationWith.text = userData["relationWith"];
          dateOfBirth.text = userData["childAge"];
          childGrade.text = userData["childGrade"];
          phoneNumber.text = userData["phoneNumber"];
          height.text = userData["height"];
          weight.text = userData["weight"];
          gender.text = userData["gender"];

          return Scaffold(
            backgroundColor: Colors.grey[300],
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/ribbon.png',
                        height: 120,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Provide your information',
                        style: TextStyle(fontSize: 20, fontFamily: 'geb'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MenuTtitle(title: 'Account Info'),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Email',
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MenuTtitle(title: 'Child Info'),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Child Name(This name will be displayed.)',
                        controller: displayName,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: dateOfBirth,
                        readOnly: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Birthdate',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: color2.withOpacity(0.3)),
                            gapPadding: 0,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType: TextInputType.datetime,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2101),
                          );

                          print("pickeddate:" + pickedDate.toString());
                          if (pickedDate != null) {
                            debugPrint(pickedDate.toString());

                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            debugPrint(formattedDate);
                            // setState(() {
                            dateOfBirth.text = formattedDate.toString();
                            // });
                            print("controller: " + dateOfBirth.text);
                          } else {
                            debugPrint("Date is not selected");
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Child Education(Class/Graduation)',
                        controller: childGrade,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Child Height(in cm)',
                        controller: height,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Gender',
                        controller: gender,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Child weight(in Kg)',
                        controller: weight,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MenuTtitle(title: 'Guardian Info'),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Guardian name',
                        controller: guardian,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Guardian Phone',
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Relation with child?',
                        controller: relationWith,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (isClick) ? CircularProgressIndicator() : Text(''),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formCheck() != "") {
                            ErrorSnackBar(context, formCheck());
                          } else {
                            setState(() {
                              isClick = true;
                            });
                            print(dateOfBirth);
                            addData(
                              user!.uid,
                              email.text.trim(),
                              guardian.text.trim(),
                              relationWith.text.trim(),
                              dateOfBirth.text.trim(),
                              childGrade.text.trim(),
                              "",
                              displayName.text.trim(),
                              phoneNumber.text.trim(),
                              height.text.trim(),
                              weight.text.trim(),
                              gender.text.trim(),
                            );
                          }
                        },
                        child: FullButton(
                          buttonText: 'Save',
                          buttonColor: Color.fromARGB(255, 221, 56, 56),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
