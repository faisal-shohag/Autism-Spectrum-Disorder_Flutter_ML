import 'package:asd/components/sheet.dart';
// import 'package:asd/models/info.dart';
import 'package:asd/models/myData.dart';
import 'package:asd/components/diagnosis_form.dart';
import 'package:asd/screens/home.dart';
import 'package:asd/screens/login.dart';
// import 'package:asd/services/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:r_nav_n_sheet/r_nav_n_sheet.dart';
import 'package:remixicon/remixicon.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyData(),
    child: const MyApp(),
  ));
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
      title: 'Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
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
      home: LoginPage(),
    );
  }
}

// MyHomePage(
//         title: 'AutiScope',
//         useLightMode: useLightMode,
//         handleBrightnessChange: (useLightMode) => setState(() {
//           _themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
//         }),
//       )

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.handleBrightnessChange,
    required this.useLightMode,
  });
  final String title;
  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> screens = [
    HomeTab(),
    Diagnosis(),
    Center(
      child: Text('Reports'),
    ),
    Center(
      child: Text('Account'),
    ),
  ];

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(),
        ),
        actions: <Widget>[
          _BrightnessButton(
            handleBrightnessChange: widget.handleBrightnessChange,
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: RNavNSheet(
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          })
        },
        sheet: Sheet(),

        // selectedItemColor: Color.fromARGB(255, 4, 4, 5),
        sheetOpenIcon: Remix.apps_line,
        sheetCloseIcon: Remix.add_line,
        sheetCloseIconBoxColor: Color.fromARGB(255, 69, 35, 190),
        sheetCloseIconColor: Colors.white,
        sheetOpenIconColor: Colors.white,
        sheetOpenIconBoxColor: Color.fromARGB(255, 76, 23, 201),
        selectedItemGradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 45, 13, 187).withOpacity(0.8),
            Color.fromARGB(255, 131, 103, 231).withOpacity(0.9),
          ],
        ),
        initialSelectedIndex: currentIndex,
        items: const [
          RNavItem(
            icon: Remix.home_2_line,
            label: 'Home',
            activeIcon: Remix.home_2_fill,
          ),
          RNavItem(
            icon: Remix.pulse_line,
            label: 'Diagnosis',
            activeIcon: Remix.pulse_fill,
          ),
          RNavItem(
            icon: Remix.pie_chart_2_line,
            label: 'Report',
            activeIcon: Remix.pie_chart_2_fill,
          ),
          RNavItem(
            icon: Remix.user_6_line,
            label: 'Account',
            activeIcon: Remix.user_6_fill,
          ),
        ],
      ),
    );
  }
}

class Diagnosis extends StatelessWidget {
  const Diagnosis({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Text(
              'ASD Diagnosis',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Diagnose with our well trained ML model and get instant result within few minutes. Follow simple 3 steps to get Result.',
              style: TextStyle(
                fontSize: 14.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/images/diag_1.jpeg',
              height: 400.0,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiagnosisForm()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, elevation: 0),
              icon: const Icon(
                Remix.pulse_fill,
                color: Colors.white,
              ),
              label: const Text(
                'Start Diagnosis',
                style: TextStyle(color: Colors.white),
              ),
            ).animate().fadeIn(duration: 500.ms).shimmer(duration: 2000.ms),
          ],
        ),
      ),
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}
