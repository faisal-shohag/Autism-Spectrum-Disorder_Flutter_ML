import 'package:asd/components/button.dart';
import 'package:asd/components/profileListItem.dart';
import 'package:asd/components/showCaseSmall.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/color.dart';
import 'package:asd/const/functions.dart';
import 'package:asd/screens/edit_profile.dart';
import 'package:asd/screens/info.dart';
import 'package:asd/services/authmiddle.dart';
// import 'package:asd/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            ErrorSnackBar(context, snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          DocumentSnapshot<Map<String, dynamic>> userData = snapshot.data!;
          if (userData["info"] == false) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage()));
                    },
                    child: FlexButton(
                      buttonText: 'Provide Info',
                      buttonColor: Colors.red,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: FlexButton(
                      width: 130,
                      prefixIcon: Remix.logout_box_line,
                      buttonText: 'Sign Out',
                      buttonColor: colorRed,
                    ),
                  ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideY(
                        duration: 500.ms,
                        begin: 0.2,
                      ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 30, right: 15),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                ),
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/boy.png'),
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  )
                  .shimmer(duration: 2000.ms),
              SizedBox(
                height: 20,
              ),
              Text(
                userData["displayName"],
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'geb',
                  color: Colors.grey[700],
                ),
              ),
              Text(userData['email']),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ShowCaseSmall(
                        val: calculateAge(userData["childAge"]).toString(),
                        title: 'Age',
                        color: colorRed),
                    Gap(10),
                    ShowCaseSmall(
                        val: centimetersToFeetAndInches(userData["height"]),
                        title: 'Height',
                        color: Colors.pink),
                    Gap(10),
                    ShowCaseSmall(
                        val: userData["weight"],
                        title: 'Weight(kg)',
                        color: Colors.amber),
                  ],
                ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
                      duration: 500.ms,
                      begin: 0.2,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 2,
                color: Colors.grey.shade200,
              ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/family.png',
                      title: userData["guardianName"],
                      subTitle: 'Guardian')
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/call.png',
                      title: '+8801318067123',
                      subTitle: 'Guardian Phone')
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/love.png',
                      title: userData['relationWith'],
                      subTitle: 'Relationship with guardian')
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/confetti.png',
                      title: formatDateString(userData['childAge']),
                      subTitle: 'Birthdate')
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/gender.png',
                      title: userData["gender"],
                      subTitle: 'Gender')
                  .animate(delay: 600.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 50,
              ),
              Divider(
                height: 2,
                color: Colors.grey.shade300,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InfoEdit()));
                },
                child: FlexButton(
                  width: 130,
                  prefixIcon: Remix.edit_box_line,
                  buttonText: 'Edit Profile',
                  buttonColor: Colors.green,
                ),
              ).animate(delay: 500.ms).fadeIn(duration: 500.ms).slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AuthCheck()));
                },
                child: FlexButton(
                  width: 130,
                  prefixIcon: Remix.logout_box_line,
                  buttonText: 'Sign Out',
                  buttonColor: colorRed,
                ),
              ).animate(delay: 500.ms).fadeIn(duration: 500.ms).slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 50,
              ),
            ]),
          );
        },
      ),
    );
  }
}
