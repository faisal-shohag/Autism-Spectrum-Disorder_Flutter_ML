import 'package:asd/components/button.dart';
import 'package:asd/screens/doctorState/docInfoEdit.dart';
import 'package:asd/screens/doctorState/docInfoProvide.dart';
import 'package:asd/screens/info.dart';
import 'package:asd/screens/notifications.dart';
import 'package:asd/services/userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  Map<String, dynamic> userData = {};
  final user = FirebaseAuth.instance.currentUser!;

  Future getUser() async {
    var data = await UserData().getDataFromFirestore(user.uid);

    setState(() {
      userData = data;
    });
    // print(userData["displayName"]);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (userData["info"] == true)
              ? Column(
                  children: [
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 159, 22, 194)
                                  .withOpacity(0.8),
                              Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight,
                          ),
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(30),
                          //   bottomRight: Radius.circular(30),
                          // ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(10, 10),
                              blurRadius: 20,
                              color: Color.fromARGB(255, 131, 103, 231)
                                  .withOpacity(0.5),
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 10,
                        bottom: 10,
                        right: 20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
                            Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(10, 10),
                            blurRadius: 20,
                            color: Color.fromARGB(255, 131, 103, 231)
                                .withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi,",
                                style: TextStyle(
                                    fontFamily: 'geb',
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Text(
                                '${userData["displayName"]}',
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  fontSize: 21,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Notifications()));
                            },
                            child: RippleAnimation(
                              color: Colors.white,
                              repeat: true,
                              minRadius: 30,
                              child: CircleAvatar(
                                child: Icon(
                                  Remix.notification_4_fill,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 40),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-1, -5),
                        blurRadius: 40,
                        color:
                            Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Remix.error_warning_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          Gap(10),
                          Text(
                            'Your profile is incomplete!',
                            style: TextStyle(
                              fontFamily: 'geb',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Some features may not be available!',
                        style: TextStyle(
                            fontFamily: 'gsb',
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocInfoProvide()));
                        },
                        child: FlexButton(
                          buttonColor: Colors.red,
                          buttonText: 'Edit Profile',
                        ),
                      ),
                    ],
                  ),
                ),
          Gap(20),
        ],
      ),
    );
  }
}
