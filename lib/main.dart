import 'package:asd/components/snackBars.dart';
import 'package:asd/models/myData.dart';
import 'package:asd/screens/about.dart';
import 'package:asd/screens/asd_test.dart';
import 'package:asd/screens/doctorZone/assignedDoctor.dart';
import 'package:asd/screens/doctorZone/reports.dart';
import 'package:asd/screens/home.dart';
import 'package:asd/screens/menu/doctor.dart';
import 'package:asd/screens/notifications.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:asd/services/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FireNotification().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASD',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Gilroy',
        brightness: Brightness.light,
      ),
      // darkTheme: ThemeData(
      //   fontFamily: GoogleFonts.poppins().fontFamily,
      //   useMaterial3: true,
      //   brightness: Brightness.light,
      // ),
      routes: {
        '/': (context) => AuthCheck(),
        '/notifications': (context) => const Notifications(),
        '/doctors': (context) => const Doctor(),
        '/assignDoctor': (context) => const AssignedDoctor(),
        '/docReports': (context) => const docReports(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    this.title,
    this.handleBrightnessChange,
    this.useLightMode,
  });
  final String? title;
  final bool? useLightMode;
  final void Function(bool useLightMode)? handleBrightnessChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> screens = [
    HomeTab(),
    ASDTEST(),
    // Reports(),
    // Profile(),
    About()
  ];

  final List<String> titles = ["", "Test", "About us"];

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentIndex != 0)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 0, bottom: 20),
                padding: EdgeInsets.only(left: 20, top: 50),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
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
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            screens[currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            var user = FirebaseAuth.instance.currentUser!;
            // print(user);

            if ((user.displayName == null || user.displayName == "") &&
                (index == 1)) {
              WarningSnackBar(
                  context, 'Please complete your profile to use this feature!');
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
              icon: Icon(Remix.pulse_line),
              label: 'Test',
              activeIcon: Icon(Remix.pulse_fill),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Remix.pie_chart_2_line),
            //   label: 'Reports',
            //   activeIcon: Icon(Remix.pie_chart_2_fill),
            // ),
            BottomNavigationBarItem(
              icon: Icon(Remix.information_line),
              label: 'About us',
              activeIcon: Icon(Remix.information_fill),
            ),
          ],
        ),
      ),
    );
  }
}
