import 'package:asd/const/color.dart';
import 'package:asd/models/myData.dart';
import 'package:asd/screens/asd_test.dart';
import 'package:asd/screens/home.dart';
import 'package:asd/screens/notificationScreen.dart';
import 'package:asd/screens/profile.dart';
import 'package:asd/screens/reports.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:asd/services/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:google_fonts/google_fonts.dart';
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
  ThemeMode _themeMode = ThemeMode.light;

  bool get useLightMode {
    switch (_themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  // This widget is the root of your application.
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
      darkTheme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
        brightness: Brightness.dark,
        // textTheme: Theme.of(context)
        //     .textTheme
        //     .apply(fontFamily: GoogleFonts.poppins().fontFamily),
      ),
      themeMode: _themeMode,
      home: AuthCheck(),
      routes: {
        '/notifications': (context) => const NotificationScreen(),
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
    Profile(),
    Reports(),
  ];

  final List<String> titles = ["Home", "Test", "Reports", "Profile"];

  var currentIndex = 0;

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    // debugPrint('SignOut');
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 187, 13, 80).withOpacity(0.8),
                    Color.fromARGB(255, 182, 26, 174).withOpacity(0.9),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 20,
                    color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text(
            //   titles[currentIndex],
            //   style: TextStyle(
            //     fontFamily: 'geb',
            //     fontSize: 20,
            //     color: Color.fromARGB(228, 39, 38, 38),
            //   ),
            // ),
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
            // color: color1.withOpacity(0.4),
            boxShadow: [
              BoxShadow(
                offset: Offset(3, -2),
                color: color1.withOpacity(0.2),
                blurRadius: 10.0,
              )
            ]),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            selectedLabelStyle: TextStyle(fontFamily: 'geb'),
            currentIndex: currentIndex,
            selectedItemColor: Colors.black,
            elevation: 0,
            unselectedItemColor: Colors.black54,
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
              BottomNavigationBarItem(
                icon: Icon(Remix.user_6_line),
                label: 'Profile',
                activeIcon: Icon(Remix.pie_chart_2_fill),
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
