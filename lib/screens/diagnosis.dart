// // import 'package:asd/components/diagnosis_form.dart';
// import 'package:asd/components/shadow_item_card2.dart';
// import 'package:asd/screens/image_diag.dart';
// import 'package:asd/screens/tests.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class Diagnosis extends StatelessWidget {
//   Diagnosis({
//     super.key,
//   });

//   final List<String> imgList = [
//     'assets/images/d1.jpg',
//     'assets/images/d2.jpeg',
//     'assets/images/d3.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           CarouselSlider(
//             items: imgList
//                 .map(
//                   (item) => Container(
//                     decoration: BoxDecoration(),
//                     child: Image.asset(
//                       item,
//                       height: 200,
//                     ),
//                   ),
//                 )
//                 .toList(),
//             options: CarouselOptions(
//               autoPlay: true,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ImageDiagnosis()));
//             },
//             child: ShadowItemCard2(
//               cardImage: 'assets/images/image.png',
//               title: 'Image Diagnosis',
//               subTitle: 'Diagnose with your child image',
//             ).animate().fadeIn(duration: 500.ms).slideY(
//                   duration: 500.ms,
//                   begin: 0.3,
//                 ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const Tests()));
//             },
//             child: ShadowItemCard2(
//               cardImage: 'assets/images/qa.png',
//               title: 'ADOS/ADI Test',
//               subTitle: 'Online question answering',
//             ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(
//                   duration: 500.ms,
//                   begin: 0.3,
//                 ),
//           ),
//           // SizedBox(
//           //   height: 10,
//           // ),
//           // ShadowItemCard2(
//           //   cardImage: 'assets/images/medical-team.png',
//           //   title: 'Consultant Diagnosis',
//           //   subTitle: 'Diagnose with expert(Image/Video Diag. is required)',
//           // ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(
//           //       duration: 500.ms,
//           //       begin: 0.3,
//           //     ),
//           SizedBox(
//             height: 10,
//           ),
//           // ElevatedButton.icon(
//           //   onPressed: () {
//           //     Navigator.push(
//           //         context,
//           //         MaterialPageRoute(
//           //             builder: (context) => const DiagnosisForm()));
//           //   },
//           //   style: ElevatedButton.styleFrom(
//           //       backgroundColor: Colors.green, elevation: 0),
//           //   icon: const Icon(
//           //     Remix.pulse_fill,
//           //     color: Colors.white,
//           //   ),
//           //   label: const Text(
//           //     'Start Diagnosis',
//           //     style: TextStyle(color: Colors.white),
//           //   ),
//           // ).animate().fadeIn(duration: 500.ms).shimmer(duration: 2000.ms),
//         ],
//       ),
//     );
//   }
// }

// // class _BrightnessButton extends StatelessWidget {
// //   const _BrightnessButton({
// //     required this.handleBrightnessChange,
// //     this.showTooltipBelow = true,
// //   });

// //   final Function handleBrightnessChange;
// //   final bool showTooltipBelow;

// //   @override
// //   Widget build(BuildContext context) {
// //     final isBright = Theme.of(context).brightness == Brightness.light;
// //     return Tooltip(
// //       preferBelow: showTooltipBelow,
// //       message: 'Toggle brightness',
// //       child: IconButton(
// //         icon: isBright
// //             ? const Icon(Icons.dark_mode_outlined)
// //             : const Icon(Icons.light_mode_outlined),
// //         onPressed: () => handleBrightnessChange(!isBright),
// //       ),
// //     );
// //   }
// // }
