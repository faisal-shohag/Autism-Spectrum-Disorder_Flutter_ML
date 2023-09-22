import 'package:asd/components/button.dart';
import 'package:asd/components/input.dart';
import 'package:asd/const/color.dart';
// import 'package:asd/const/color.dart';
// import 'package:asd/main.dart';
import 'package:asd/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_animate/flutter_animate.dart';

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
  TextEditingController childAge = TextEditingController();
  TextEditingController childGrade = TextEditingController();

  bool checkVal = false;

  Future signUp(context) async {
    try {
      var res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      debugPrint(error.toString());
      ErrorSnackBar(context, error.toString());
    }
    // debugPrint(res.toString());
  }

  void ErrorSnackBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: colorRed,
    ));
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
                  InputTextField(
                    obscureText: false,
                    hintText: 'Child Name(This name will be displayed.)',
                    controller: displayName,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    obscureText: false,
                    hintText: 'Guardian name',
                    controller: guardian,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    obscureText: false,
                    hintText: 'Relation with child?',
                    controller: relationWith,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    obscureText: false,
                    hintText: 'Child age',
                    controller: childAge,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    obscureText: false,
                    hintText: 'Child grade',
                    controller: childGrade,
                    keyboardType: TextInputType.number,
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
                  checkVal
                      ? GestureDetector(
                          onTap: () => {signUp(context)},
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
                      Navigator.push(context,
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
