import 'package:asd/components/button.dart';
import 'package:asd/components/input.dart';
// import 'package:asd/components/menutitle.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/RegEx.dart';
import 'package:asd/const/color.dart';
// import 'package:asd/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocInfoEdit extends StatefulWidget {
  const DocInfoEdit({super.key});

  @override
  State<DocInfoEdit> createState() => _DocInfoEditState();
}

class _DocInfoEditState extends State<DocInfoEdit> {
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
  Future addData(uid, email, degree, presentInstitute, dateOfBirth, speciality,
      photoUrl, displayName, gender, presentAddress) async {
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
        "presentAddress": presentAddress,
      });
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
          degree.text = userData["guardianName"];
          displayName.text = userData["displayName"];
          presentInstitute.text = userData["relationWith"];
          dateOfBirth.text = userData["childAge"];
          speciality.text = userData["childGrade"];
          gender.text = userData["gender"];
          presentAddress.text = userData["presentAddress"];

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
                      // MenuTtitle(title: 'Guardian Info'),
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
                            // print(dateOfBirth);
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
                              presentAddress.text.trim(),
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
