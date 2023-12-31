// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:pedometer/pedometer.dart';

// String formatDate(DateTime d) {
//   return d.toString().substring(0, 19);
// }

// class PedoMeter extends StatefulWidget {
//   @override
//   _PedoMeterState createState() => _PedoMeterState();
// }

// class _PedoMeterState extends State<PedoMeter> {
//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;
//   String _status = '?', _steps = '?';

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   void onStepCount(StepCount event) {
//     print(event);
//     setState(() {
//       _steps = event.steps.toString();
//     });
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print(event);
//     setState(() {
//       _status = event.status;
//     });
//   }

//   void onPedestrianStatusError(error) {
//     print('onPedestrianStatusError: $error');
//     setState(() {
//       _status = 'Pedestrian Status not available';
//     });
//     print(_status);
//   }

//   void onStepCountError(error) {
//     print('onStepCountError: $error');
//     setState(() {
//       _steps = 'Step Count not available';
//     });
//   }

//   void initPlatformState() {
//     _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//     _pedestrianStatusStream
//         .listen(onPedestrianStatusChanged)
//         .onError(onPedestrianStatusError);

//     _stepCountStream = Pedometer.stepCountStream;
//     _stepCountStream.listen(onStepCount).onError(onStepCountError);

//     if (!mounted) return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           'Steps Taken',
//           style: TextStyle(fontSize: 30),
//         ),
//         Text(
//           _steps,
//           style: TextStyle(fontSize: 60),
//         ),
//         Divider(
//           height: 100,
//           thickness: 0,
//           color: Colors.white,
//         ),
//         Text(
//           'Pedestrian Status',
//           style: TextStyle(fontSize: 30),
//         ),
//         Icon(
//           _status == 'walking'
//               ? Icons.directions_walk
//               : _status == 'stopped'
//                   ? Icons.accessibility_new
//                   : Icons.error,
//           size: 100,
//         ),
//         Center(
//           child: Text(
//             _status,
//             style: _status == 'walking' || _status == 'stopped'
//                 ? TextStyle(fontSize: 30)
//                 : TextStyle(fontSize: 20, color: Colors.red),
//           ),
//         )
//       ],
//     );
//   }
// }
