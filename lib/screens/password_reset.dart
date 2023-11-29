import 'package:asd/components/button.dart';
import 'package:asd/components/input.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/RegEx.dart';
import 'package:asd/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remixicon/remixicon.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

  bool isSent = false;
  bool isClickSend = false;

  Future sendResetEmail(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        isSent = true;
      });
    } on FirebaseAuthException catch (error) {
      ErrorSnackBar(context, error.message);
    }
  }

  @override
  void dispose() {
    isSent = false;
    isClickSend = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: (isSent)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/ribbon.png',
                          height: 120,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Email has been sent!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Remix.checkbox_circle_fill,
                          size: 50,
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            'Please check your inbox and reset your password then Log in!'),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: FullButton(
                            buttonText: 'Back to Login',
                            buttonColor: Color.fromARGB(255, 12, 4, 17),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/ribbon.png',
                          height: 120,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Reset password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InputTextField(
                          readOnly: false,
                          obscureText: false,
                          hintText: 'Email',
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (isClickSend)
                            ? FullButton(
                                buttonText: 'Sending...',
                                buttonColor: Color.fromARGB(255, 161, 41, 33),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (email.text == "") {
                                    WarningSnackBar(context,
                                        'Please provide email address!');
                                  } else if (emailRegx.hasMatch(email.text)) {
                                    setState(() {
                                      isClickSend = true;
                                    });
                                    sendResetEmail(email.text);
                                  } else {
                                    WarningSnackBar(
                                        context, 'Invalid email address!');
                                  }
                                },
                                child: FullButton(
                                  buttonText: 'Send Email',
                                  buttonColor: Color.fromARGB(255, 221, 56, 56),
                                ),
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
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: FullButton(
                            buttonText: 'Back to Login',
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
