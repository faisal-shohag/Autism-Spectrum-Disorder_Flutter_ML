import 'package:asd/components/snackBars.dart';
import 'package:asd/screens/doctorState/patients.dart';
import 'package:asd/screens/doctorState/profile.dart';
import 'package:asd/screens/doctorState/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class DoctorState extends StatefulWidget {
  const DoctorState({super.key});

  @override
  State<DoctorState> createState() => _DoctorStateState();
}

class _DoctorStateState extends State<DoctorState> {
  final List<Widget> screens = [
    Patients(),
    Requests(),
    DocProfile(),
  ];

  final List<String> titles = ["", "Requests", "Profile"];

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (currentIndex != 0)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 0, bottom: 20),
                padding: EdgeInsets.only(left: 20, top: 30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
                      Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      blurRadius: 20,
                      color:
                          Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titles[currentIndex],
                      style: TextStyle(
                        fontFamily: 'geb',
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            // SizedBox(
            //   height: 10,
            // ),
            screens[currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              // print(user.displayName);
              var user = FirebaseAuth.instance.currentUser!;
              if (user.displayName == null && (index == 1 || index == 2)) {
                WarningSnackBar(context,
                    'Please complete your profile to use this feature!');
              } else {
                setState(() {
                  currentIndex = index;
                });
              }
            },
            backgroundColor: Colors.transparent,
            selectedLabelStyle: TextStyle(fontFamily: 'geb'),
            currentIndex: currentIndex,
            selectedItemColor: Color.fromARGB(255, 55, 39, 201),
            elevation: 0,
            unselectedItemColor:
                Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Remix.home_2_line),
                label: 'Home',
                activeIcon: Icon(Remix.home_2_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(Remix.empathize_line),
                label: 'Requests',
                activeIcon: Icon(Remix.empathize_fill),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Remix.pie_chart_2_line),
              //   label: 'Reports',
              //   activeIcon: Icon(Remix.pie_chart_2_fill),
              // ),
              BottomNavigationBarItem(
                icon: Icon(Remix.user_6_line),
                label: 'Profile',
                activeIcon: Icon(Remix.user_6_fill),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Remix.user_6_line),
              //   label: '...',
              //   activeIcon: Icon(Remix.user_6_fill),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
