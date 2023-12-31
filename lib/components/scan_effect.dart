// // Thank you to the author of the original post that this widget was build base on it.
// // https://medium.com/@webianks/scanning-animation-in-flutter-99fb26aabbb7

// import 'package:flutter/material.dart';
// import 'package:scanning_effect/scanner_animation.dart';
// // import 'package:scanning_effect/scanner_border_painter.dart';

// /// The [ScanningEffect] is the view where scanner animation
// /// and scanning border line display.
// class ScanningEffect extends StatefulWidget {
//   const ScanningEffect({
//     super.key,
//     required this.child,
//     this.scanningColor = Colors.blue,
//     // this.borderLineColor = Colors.red,
//     this.scanningHeightOffset = 0.2,
//     this.delay = const Duration(milliseconds: 700),
//     this.duration = const Duration(milliseconds: 2800),
//     this.scanningLinePadding =
//         const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
//   });

//   final Widget child;
//   final Color scanningColor;
//   final double scanningHeightOffset;
//   final Duration delay;
//   final Duration duration;
//   final EdgeInsetsGeometry scanningLinePadding;

//   @override
//   State<ScanningEffect> createState() => _ScanningEffectState();
// }

// class _ScanningEffectState extends State<ScanningEffect>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: widget.duration,
//       vsync: this,
//     );

//     _animationController
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           Future.delayed(
//             widget.delay,
//             () {
//               _animationController
//                 ..reset()
//                 ..forward(from: 0);
//             },
//           );
//         }
//       })
//       ..forward(from: 0);
//     _animationController.stop();
//     // stoppingAnimation();
//   }

//   // Future stoppingAnimation() async {
//   //   await Future.delayed(const Duration(seconds: 5));
//   //   _animationController.reset();
//   //   _animationController.stop();
//   // }

//   @override
//   void dispose() {
//     _animationController.stop();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         widget.child,
//         Padding(
//           padding: widget.scanningLinePadding,
//           child: ClipRect(
//             child: ScannerAnimation(
//               animation: _animationController,
//               scanningColor: widget.scanningColor,
//               scanningHeightOffset: widget.scanningHeightOffset,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
