// import 'package:asd/components/button.dart';
// import 'package:asd/components/menutitle.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gap/gap.dart';
// import 'package:remixicon/remixicon.dart';
// import 'package:simple_ripple_animation/simple_ripple_animation.dart';

// class Schedules extends StatefulWidget {
//   const Schedules({super.key});

//   @override
//   State<Schedules> createState() => _SchedulesState();
// }

// class _SchedulesState extends State<Schedules> {
//   final isAssign = true;
//   final user = FirebaseAuth.instance.currentUser!;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red.shade600,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Icon(
//             Remix.arrow_left_s_line,
//             color: Colors.white,
//             size: 30,
//           ),
//         ),
//         title: const Text(
//           'Doctor',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: (!isAssign)
//           ? Container(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.network(
//                     'https://firebasestorage.googleapis.com/v0/b/asd-ml.appspot.com/o/Assets%2Fproject.png?alt=media&token=5648331f-f7b0-4bf7-a88a-1cbb4ce62067',
//                     height: 100,
//                   ),
//                   Gap(20),
//                   Text(
//                     "Schedules from your doctor will be appeared here!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'geb',
//                       fontSize: 18,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MenuTtitle(
//                   title: 'Assigned Doctor',
//                 ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
//                       duration: 500.ms,
//                       begin: 0.3,
//                     ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         offset: Offset(2, 3),
//                         blurRadius: 20,
//                         color:
//                             Color.fromARGB(255, 131, 127, 127).withOpacity(0.2),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       RippleAnimation(
//                         repeat: true,
//                         minRadius: 50,
//                         color: Colors.purple,
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundImage: NetworkImage(
//                               'https://www.felixhospital.com/sites/default/files/2022-11/dr-aditi-narad.jpg'),
//                         ),
//                       ),
//                       Gap(15),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Dr. Aditi Narad",
//                             style: TextStyle(fontSize: 20, fontFamily: 'geb'),
//                           ),
//                           // Gap(5),
//                           Text(
//                             'BASLP, MASLP',
//                             style: TextStyle(
//                               fontFamily: 'gsb',
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             'Audiology & Speech Therapy',
//                             style: TextStyle(
//                               fontFamily: 'gsb',
//                               fontSize: 14,
//                             ),
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Remix.map_pin_2_fill,
//                                 size: 15,
//                               ),
//                               Gap(3),
//                               Text(
//                                 'Rangpur',
//                                 style: TextStyle(
//                                   fontFamily: 'gsb',
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.pink,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                         bottomLeft: Radius.circular(10),
//                       )),
//                   child: Text(
//                     "Hi ${user.displayName}, \nI'll reach you soon with our consultation schedule. ",
//                     // textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'gsb',
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
