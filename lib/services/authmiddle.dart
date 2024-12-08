import 'package:asd/components/snackBars.dart';
import 'package:asd/main.dart';
import 'package:asd/screens/agreement/agreement.dart';
import 'package:asd/screens/doctorState/doctorState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    // var uid = FirebaseAuth.instance.currentUser!.uid;

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
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
                if (snap.hasError) {
                  ErrorSnackBar(context, snap.error);
                }

                // if (snap.connectionState == ConnectionState.waiting) {

                // }
                if (snap.hasData) {
                  DocumentSnapshot<Map<String, dynamic>> userData = snap.data!;
                  // print(userData);

                  if (userData["access"] == "waiting") {
                    return Scaffold(
                      backgroundColor: Color.fromARGB(255, 6, 7, 17),
                      body: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Gap(30),
                            Image.asset(
                              'assets/images/ribbon.png',
                              height: 60,
                            ),
                            Gap(5),
                            Text(
                              "AI Autism Detection",
                              style: TextStyle(
                                fontFamily: 'geb',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            // Gap(5),
                            Text(
                              "First AI based Autism Detection App in Bangladesh!",
                              style: TextStyle(
                                fontFamily: 'gsb',
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            Gap(50),

                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Waiting for Admin Approval!',
                                    style: TextStyle(
                                      fontFamily: 'geb',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Gap(5),
                                  Text(
                                    'You have successfully created an account. We\'ll reach you soon! If the delay persist please contact us by admin@gmail.com',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'geb',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (userData["join_as"] == "") {
                    return MyHomePage();
                  }
                  print("JOIN AS: ${userData['join_as']}");
                  if (userData["join_as"] == "doctor") {
                    return DoctorState();
                  }

                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Container(
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
                    ),
                  );
                }
                return const SafeArea(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
          return Agreement();
        },
      ),
    );
  }
}
