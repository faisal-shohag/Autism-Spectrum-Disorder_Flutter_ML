import 'package:asd/components/button.dart';
// import 'package:asd/const/color.dart';
// import 'package:asd/main.dart';
import 'package:asd/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_animate/flutter_animate.dart';
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
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
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
                  InputTextField(
                    obscureText: false,
                    hintText: 'Email',
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    obscureText: true,
                    hintText: 'Password',
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Forget password?',
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => {
                      (email.text.trim() != "" && password.text.trim() != "")
                          ? sinIn()
                          : ErrorSnackBar(
                              context, 'Please fill all the fields!')
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
                      Navigator.push(
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
