import 'package:asd/components/snackBars.dart';
import 'package:asd/const/color.dart';
import 'package:asd/main.dart';
// import 'package:asd/screens/login.dart';
import 'package:asd/screens/phoneAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(snapshot.data!.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snap) {
                  if (snap.hasError) {
                    ErrorSnackBar(context, snap.error);
                  }

                  if (snap.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                          top: 50,
                          bottom: 50,
                        ),
                        color: Colors.black87,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/ribbon.png',
                                  height: 100,
                                ),
                                Gap(40),
                                Text(
                                  'AutiScope',
                                  style: TextStyle(
                                    fontFamily: 'geb',
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                Gap(50),
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                Gap(20),
                                Text(
                                  'Preparing the app...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'App version 1.1.0\nMade with Flutter',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  DocumentSnapshot<Map<String, dynamic>> userData = snap.data!;

                  if (userData["access"] == "waiting") {
                    return Scaffold(
                      backgroundColor: Colors.grey.shade300,
                      body: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
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
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/waiting.gif'),
                                  )),
                            ),
                            Text(
                              'Waiting for Admin Approval!',
                              style: TextStyle(
                                fontFamily: 'geb',
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RichText(
                              softWrap: true,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text:
                                    'You have successfully created an account! Please send an email to this address:',
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'gsb'),
                                children: [
                                  TextSpan(
                                    text: ' email_address@gmail.com.',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 17, 81, 165),
                                        fontFamily: 'gsb'),
                                  ),
                                  TextSpan(
                                    text: ' Mention this USER ID: ',
                                    style: TextStyle(
                                        color: Colors.black, fontFamily: 'gsb'),
                                  ),
                                  TextSpan(
                                    text: '${snapshot.data!.uid}',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 17, 81, 165),
                                        fontFamily: 'gsb'),
                                  ),
                                  TextSpan(
                                    text:
                                        ' and briefly explain why you need this app!',
                                    style: TextStyle(
                                        color: Colors.black, fontFamily: 'gsb'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return MyHomePage();
                });
          }
          return PhoneAuth();
        },
      ),
    );
  }
}
