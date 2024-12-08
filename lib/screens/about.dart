import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Government_Seal_of_Bangladesh.svg/220px-Government_Seal_of_Bangladesh.svg.png',
                height: 80,
              ),
              Gap(30),
              Image.network(
                'https://seeklogo.com/images/B/begum-rokeya-university-logo-788D681CE6-seeklogo.com.png',
                height: 80,
              ),
            ],
          ),
          Gap(30),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'This work was partially supported by the ICT Division, Government of the People’s Republic of Bangladesh, No: (1280101-120008431-3631108).',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Gap(20),
                Text(
                  'The app was developed and maintained by the Department of Computer Science and Engineering, Begum Rokeya University, Rangpur.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Gap(30),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  'Our app uses cutting-edge machine learning models to detect autism in children. By answering a series of questions and analyzing images, we aim to provide an early detection tool for parents and caregivers.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Gap(20),
                Text(
                  'Thank you for using our app. Together, we can make a difference in the lives of children with autism.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
