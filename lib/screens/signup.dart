// import 'dart:convert';

import 'package:asd/components/button.dart';
// import 'package:asd/components/diagnosis_form.dart';
import 'package:asd/components/input.dart';
import 'package:asd/components/menutitle.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/RegEx.dart';
// import 'package:asd/const/color.dart';
import 'package:asd/models/user.dart';
// import 'package:asd/const/color.dart';
// import 'package:asd/main.dart';
import 'package:asd/screens/login.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_animate/flutter_animate.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
  bool isClickSignUp = false;

  Future signUp(context) async {
    try {
      var res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // print(res);
      if (res.user != null) {
        res.user?.updateDisplayName(displayName.text);
      }

      var data = res.user;
      addData(
          data!.uid,
          data.email,
          guardian.text,
          relationWith.text,
          dateOfBirth.text,
          childGrade.text,
          "",
          displayName.text,
          phoneNumber.text,
          height.text,
          weight.text,
          gender.text);
    } on FirebaseAuthException catch (error) {
      debugPrint(error.toString());
      ErrorSnackBar(context, error.toString());
    }
    // debugPrint(res.toString());
  }

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
      gender) async {
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
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(data.toJson());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthCheck()));
      setState(() {
        isClickSignUp = false;
      });
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      setState(() {
        isClickSignUp = false;
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
    if (email.text == "" ||
        password.text == "" ||
        guardian.text == "" ||
        relationWith.text == "" ||
        dateOfBirth.text == "" ||
        displayName.text == "" ||
        phoneNumber.text == "" ||
        childGrade.text == "") {
      return "Please fill all the field!";
    }
    return "";
  }

  @override
  void dispose() {
    super.dispose();
    checkVal = false;
    isClickSignUp = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
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
                    'Create Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                  InputTextField(
                    readOnly: false,
                    obscureText: true,
                    hintText: 'Password',
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
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
                  InputTextField(
                    readOnly: true,
                    obscureText: false,
                    hintText: 'Child Birthdate',
                    controller: dateOfBirth,
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              1990), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        debugPrint(pickedDate
                            .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        debugPrint(formattedDate);
                        setState(() {
                          dateOfBirth.text = formattedDate;
                        });
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
                  Row(
                    children: [
                      Checkbox(
                        value: checkVal,
                        onChanged: (val) =>
                            {setState(() => checkVal = !checkVal)},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Agree with Terms & Conditions.'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (isClickSignUp) ? CircularProgressIndicator() : Text(''),
                  SizedBox(
                    height: 10,
                  ),
                  checkVal
                      ? GestureDetector(
                          onTap: () {
                            if (formCheck() != "") {
                              ErrorSnackBar(context, formCheck());
                            } else {
                              setState(() {
                                isClickSignUp = true;
                              });
                              signUp(context);
                            }
                          },
                          child: FullButton(
                            buttonText: 'Sign Up',
                            buttonColor: Color.fromARGB(255, 221, 56, 56),
                          ),
                        )
                      : FullButton(
                          buttonText: 'Sign Up',
                          buttonColor: Color.fromARGB(255, 201, 96, 96),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()))
                    },
                    child: FullButton(
                      buttonText: 'Login',
                      buttonColor: Color.fromARGB(255, 12, 4, 17),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
