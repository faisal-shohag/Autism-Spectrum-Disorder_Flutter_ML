import 'package:asd/components/button.dart';
import 'package:asd/components/input.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/RegEx.dart';
import 'package:asd/main.dart';
import 'package:asd/screens/doctorState/doctorState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocInfoProvide extends StatefulWidget {
  const DocInfoProvide({super.key});

  @override
  State<DocInfoProvide> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<DocInfoProvide> {
  TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController displayName = TextEditingController();
  TextEditingController presentInstitute = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController speciality = TextEditingController();
  TextEditingController presentAddress = TextEditingController();
  // TextEditingController height = TextEditingController();
  // TextEditingController weight = TextEditingController();
  TextEditingController gender = TextEditingController();

  bool checkVal = false;
  bool isClick = false;

  var user = FirebaseAuth.instance.currentUser;
  Future addData(
    uid,
    email,
    degree,
    presentInstitute,
    dateOfBirth,
    speciality,
    photoUrl,
    displayName,
    gender,
    context,
    presentAddress,
  ) async {
    FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        "uid": uid,
        "email": email,
        "degree": degree,
        "presentInstitute": presentInstitute,
        "dateOfBirth": dateOfBirth,
        "speciality": speciality,
        "photoURL": "",
        "displayName": displayName,
        "gender": gender,
        "info": true,
        "presentAddress": presentAddress,
      });

      setState(() {
        isClick = false;
      });
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoctorState()));
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      setState(() {
        isClick = false;
      });
    }
  }

  String formCheck() {
    if (!emailRegx.hasMatch(email.text)) {
      return "Invalid email!";
    }
    if (email.text.trim() == "" ||
        degree.text.trim() == "" ||
        presentInstitute.text.trim() == "" ||
        dateOfBirth.text.trim() == "" ||
        displayName.text.trim() == "" ||
        speciality.text.trim() == "" ||
        presentAddress.text.trim() == "" ||
        gender.text.trim() == "") {
      return "Please fill all the field!";
    }
    return "";
  }

  @override
  void dispose() {
    super.dispose();
    checkVal = false;
    isClick = false;
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 20,
                ),
                // MenuTtitle(title: 'Account Info'),
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
                // SizedBox(
                //   height: 10,
                // ),
                // MenuTtitle(title: 'Child Info'),
                InputTextField(
                  readOnly: false,
                  obscureText: false,
                  hintText: 'Name',
                  controller: displayName,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                InputTextField(
                  readOnly: true,
                  obscureText: false,
                  hintText: 'Birthdate',
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
                      // setState(() {
                      dateOfBirth.text = formattedDate;
                      // });
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
                  hintText: 'Degree',
                  controller: degree,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                InputTextField(
                  readOnly: false,
                  obscureText: false,
                  hintText: 'Present Institute',
                  controller: presentInstitute,
                  keyboardType: TextInputType.text,
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
                  hintText: 'Speciality',
                  controller: speciality,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                // MenuTtitle(title: 'Present Address'),
                InputTextField(
                  readOnly: false,
                  obscureText: false,
                  hintText: 'Present Address',
                  controller: presentAddress,
                  keyboardType: TextInputType.text,
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // InputTextField(
                //   readOnly: false,
                //   obscureText: false,
                //   hintText: 'Guardian Phone',
                //   controller: phoneNumber,
                //   keyboardType: TextInputType.number,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // InputTextField(
                //   readOnly: false,
                //   obscureText: false,
                //   hintText: 'Relation with child?',
                //   controller: relationWith,
                //   keyboardType: TextInputType.text,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
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
                (isClick) ? CircularProgressIndicator() : Text(''),
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
                              isClick = true;
                            });
                            addData(
                              user!.uid,
                              email.text.trim(),
                              degree.text.trim(),
                              presentInstitute.text.trim(),
                              dateOfBirth.text.trim(),
                              speciality.text.trim(),
                              "",
                              displayName.text.trim(),
                              gender.text.trim(),
                              context,
                              presentAddress.text.trim(),
                            );
                          }
                        },
                        child: FullButton(
                          buttonText: 'Save',
                          buttonColor: Color.fromARGB(255, 221, 56, 56),
                        ),
                      )
                    : FullButton(
                        buttonText: 'Save',
                        buttonColor: Color.fromARGB(255, 201, 96, 96),
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
  }
}
