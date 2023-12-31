import 'dart:async';
import 'package:asd/components/button.dart';
import 'package:asd/const/RegEx.dart';
// import 'package:asd/main.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asd/components/snackBars.dart';
import 'package:gap/gap.dart';
import '../components/input.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phone = TextEditingController();

  String? verificationId;
  bool isClickLogin = false;
  bool isSent = false;

  Timer? timer;
  int start = 0;
  SingleValueDropDownController drop_controller =
      SingleValueDropDownController();
  String joinAs = "";

  void startTime() {
    const sec = Duration(seconds: 1);
    timer = new Timer.periodic(sec, (timer) {
      if (start == 0) {
        if (!mounted) {
          return;
        }
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Future<void> verifyPhoneNumber(BuildContext context, bool isResend) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+88" + phone.text.trim(),
      // timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential phoneAuthCredential) {
        SuccessSnackBar(context, 'Verification Successfull!');
        if (!mounted) {
          return;
        }
        setState(() {
          isClickLogin = false;
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        if (!mounted) {
          return;
        }
        setState(() {
          isClickLogin = false;
        });
        debugPrint(authException.toString());
        ErrorSnackBar(context, 'Something went wrong!');
      },
      codeSent: (String verId, forceResendingToken) {
        verificationId = verId;
        if (!mounted) {
          return;
        }
        setState(() {
          isClickLogin = false;
          if (!isResend) {
            start = 30;
            startTime();
            isSent = true;
          }
        });
      },
      codeAutoRetrievalTimeout: (String verId) {
        if (!mounted) {
          return;
        }
        setState(() {
          isClickLogin = false;
          timer!.cancel();
        });
        verificationId = verId;
        WarningSnackBar(context, 'Time out! Please resend code!');
      },
    );
  }

  TextEditingController OTP = TextEditingController();

  Future<void> signIn(String otp, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId as String,
        smsCode: otp,
      ));
      // if (!mounted) {
      //   return;
      // }
      // setState(() {
      //   if (mounted) {
      //     timer!.cancel();
      //   }
      // });

      final user = FirebaseAuth.instance.currentUser;
      print(user!);
      if (user.displayName == null) {
        if (joinAs == "doctor") {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            "access": "waiting",
            "info": false,
            "join_as": joinAs,
            "displayName": "",
            "phone": phone.text.trim(),
            // "notifications": {},
            "patients": {},
            "requests": {},
            "photoURL": "",
            "ntf": false,
            "req": false,
          });
        } else {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            "access": "waiting",
            "info": false,
            "join_as": joinAs,
            "displayName": "",
            "photoURL": "",
            "phone": phone.text.trim(),
            "available": true,
            // "notifications": {},
            "ntf": false,
            "req": false,
            "assign": {}
          });
        }
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthCheck()));
    } on FirebaseAuthException catch (e) {
      ErrorSnackBar(context, e.message);
      setState(() {
        isClickLogin = false;
      });
    }
  }

  // OTPDialogBox(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           title: Text('Enter your OTP'),
  //           content: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: InputTextField(
  //               controller: OTP,
  //               hintText: 'Enter OTP',
  //               keyboardType: TextInputType.text,
  //               obscureText: false,
  //               readOnly: false,
  //             ),
  //           ),
  //           contentPadding: EdgeInsets.all(10.0),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 signIn(OTP.text.trim(), context);
  //               },
  //               child: Text(
  //                 'Verify',
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  void dispose() {
    isClickLogin = false;
    if (timer != null) {
      timer!.cancel();
    }
    drop_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 234, 234),
      body: Center(
        child: (isSent)
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/asd-ml.appspot.com/o/Assets%2Ffingerprint-scanner.png?alt=media&token=20384a6e-f6db-4e46-9840-1c4fee2c04a7',
                        height: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Verify with OTP',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'geb',
                        ),
                      ),
                      Text(
                        'A 6 digit verification code has been sent to your number.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isClickLogin ? CircularProgressIndicator() : Text(''),
                      isClickLogin
                          ? SizedBox(
                              height: 20,
                            )
                          : Text(''),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Enter verification code here...',
                        controller: OTP,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      (start != 0)
                          ? Text(
                              'Resend in $start',
                              style: TextStyle(fontFamily: 'geb'),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (!mounted) {
                                  return;
                                }
                                setState(() {
                                  timer!.cancel();
                                  start = 30;
                                  startTime();
                                });

                                verifyPhoneNumber(context, true);
                              },
                              child: Text(
                                'Resend code',
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (phoneRegx.hasMatch(phone.text.trim())) {
                            setState(() {
                              isClickLogin = true;
                            });
                            // verifyPhoneNumber(context);
                            signIn(OTP.text.trim(), context);
                            // OTPDialogBox(context);
                          } else {
                            WarningSnackBar(context, 'Invalid Phone Number!');
                          }
                        },
                        child: FullButton(
                          buttonText: 'Verify',
                          buttonColor: Color.fromARGB(255, 221, 56, 56),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/asd-ml.appspot.com/o/Assets%2Ffingerprint-scanner.png?alt=media&token=20384a6e-f6db-4e46-9840-1c4fee2c04a7',
                        height: 120,
                      ),
                      Gap(20),
                      Text(
                        'Login with Phone',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'geb',
                        ),
                      ),
                      Text(
                        'Please provide phone number without country code. Example: 01234567890',
                        textAlign: TextAlign.center,
                      ),
                      Gap(20),
                      isClickLogin ? CircularProgressIndicator() : Text(''),
                      isClickLogin ? Gap(20) : Text(''),
                      DropDownTextField(
                        textFieldDecoration: InputDecoration(
                          hintText: 'Login As',
                          contentPadding: EdgeInsets.only(left: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.red.withOpacity(0.3)),
                            gapPadding: 0,
                          ),
                        ),
                        controller: drop_controller,
                        listSpace: 10,
                        listPadding: ListPadding(top: 20),
                        dropDownList: [
                          DropDownValueModel(
                              name: 'Login As Parent', value: 'parent'),
                          DropDownValueModel(
                              name: 'Login As Doctor', value: 'doctor'),
                        ],
                        onChanged: (val) {
                          if (val.runtimeType != String) {
                            setState(() {
                              joinAs = val.value;
                            });
                          } else {
                            setState(() {
                              joinAs = "";
                            });
                          }
                        },
                      ),
                      Gap(10),
                      InputTextField(
                        readOnly: false,
                        obscureText: false,
                        hintText: 'Phone number',
                        controller: phone,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Gap(15),
                      GestureDetector(
                        onTap: () {
                          if (joinAs == "") {
                            WarningSnackBar(context, "Please select Login as!");
                          } else if (phoneVerifyRegx.hasMatch(phone.text)) {
                            if (!mounted) {
                              return;
                            }
                            setState(() {
                              isClickLogin = true;
                            });
                            verifyPhoneNumber(context, false);
                            // OTPDialogBox(context);
                          } else {
                            WarningSnackBar(context, 'Invalid Phone Number!');
                          }
                        },
                        child: FullButton(
                          buttonText: 'Send Verification Code',
                          buttonColor: Color.fromARGB(255, 221, 56, 56),
                        ),
                      ),
                      Gap(50),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
