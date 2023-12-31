import 'package:asd/components/button.dart';
import 'package:asd/const/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';

class DocProfile extends StatefulWidget {
  const DocProfile({super.key});

  @override
  State<DocProfile> createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: FlexButton(
            width: 130,
            prefixIcon: Remix.logout_box_line,
            buttonText: 'Sign Out',
            buttonColor: colorRed,
          ),
        ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
              duration: 500.ms,
              begin: 0.2,
            ),
      ],
    );
  }
}
