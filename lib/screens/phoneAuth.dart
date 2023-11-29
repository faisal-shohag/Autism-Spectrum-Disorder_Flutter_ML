import 'dart:async';
import 'package:asd/components/button.dart';
import 'package:asd/const/RegEx.dart';
// import 'package:asd/main.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asd/components/snackBars.dart';
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
      phoneNumber: phone.text.trim(),
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
      setState(() {
        if (mounted) {
          timer!.cancel();
        }
      });

      final user = FirebaseAuth.instance.currentUser;
      print(user!);
      if (user.displayName == null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({"access": "waiting", "info": false});
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

  OTPDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter your OTP'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputTextField(
                controller: OTP,
                hintText: 'Enter OTP',
                keyboardType: TextInputType.text,
                obscureText: false,
                readOnly: false,
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  signIn(OTP.text.trim(), context);
                },
                child: Text(
                  'Verify',
                ),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    isClickLogin = false;
    if (timer != null) {
      timer!.cancel();
    }

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
                      Image.asset(
                        'assets/images/ribbon.png',
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
                      Image.asset(
                        'assets/images/ribbon.png',
                        height: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login with Phone',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'geb',
                        ),
                      ),
                      Text(
                        'Please provide phone number with country code. Example: +8801234567890',
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
                        hintText: 'Phone number',
                        controller: phone,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (phoneVerifyRegx.hasMatch(phone.text)) {
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
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
