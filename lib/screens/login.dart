import 'package:asd/components/button.dart';
import 'package:asd/const/RegEx.dart';
import 'package:asd/const/color.dart';
import 'package:asd/screens/password_reset.dart';
import 'package:asd/screens/signup.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:asd/components/snackBars.dart';
import '../components/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future sinIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthCheck()));
    } on FirebaseAuthException catch (error) {
      ErrorSnackBar(context, error.message);
      setState(() {
        isClickLogin = false;
      });
    }
  }

  bool isClickLogin = false;

  @override
  void dispose() {
    isClickLogin = false;
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
              child: Column(
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
                    'Login to your Account!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forget password?',
                        // textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()));
                        },
                        child: Text(
                          'Reset password',
                          style: TextStyle(
                              color: color1, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (password.text.length < 6) {
                        WarningSnackBar(
                            context, 'Password must be atleast 6 digits.');
                      } else if (emailRegx.hasMatch(email.text)) {
                        setState(() {
                          isClickLogin = true;
                        });
                        sinIn();
                      } else {
                        WarningSnackBar(context, 'Invalid Email Address!');
                      }
                    },
                    child: FullButton(
                      buttonText: 'Login',
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
                    onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()))
                    },
                    child: FullButton(
                      buttonText: 'Sign Up',
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
