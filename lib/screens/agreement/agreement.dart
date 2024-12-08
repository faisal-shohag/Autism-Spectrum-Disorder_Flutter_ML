import 'package:asd/components/button.dart';
import 'package:asd/screens/agreement/privacy_policy.dart';
import 'package:asd/screens/agreement/terms_of_use.dart';
import 'package:asd/screens/phoneAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full background image
          Image.network(
            'https://i.postimg.cc/pdFgwRzH/image.png',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Color.fromARGB(255, 20, 18, 37),
                child: Center(
                  child: Icon(Icons.error, color: Colors.red, size: 50),
                ),
              );
            },
          ),

          // Semi-transparent overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // Existing content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(100),
              Image.asset(
                'assets/images/ribbon.png',
                height: 60,
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  )
                  .shimmer(duration: 2000.ms),
              Gap(5),
              Text(
                "BRUR ASD",
                style: TextStyle(
                  fontFamily: 'geb',
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: 500.ms,
                  )
                  .slideY(
                    duration: 500.ms,
                    begin: 0.3,
                  ),
              Center(
                child: Text(
                  "First AI-based Autism Detection & Evaluation App in Bangladesh!",
                  style: TextStyle(
                      fontFamily: 'gsb', fontSize: 13, color: Colors.blue),
                )
                    .animate()
                    .fadeIn(
                      duration: 500.ms,
                    )
                    .slideY(
                      duration: 500.ms,
                      begin: 0.4,
                    ),
              ),
            ],
          ),

          // Bottom Sheet
          Positioned(
            height: MediaQuery.of(context).size.height / 3.2,
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agreements',
                    style: TextStyle(
                      fontFamily: 'geb',
                      fontSize: 20,
                    ),
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Icon(Icons.check),
                      Gap(3),
                      Row(
                        children: [
                          Text(
                            'I agree to',
                            style: TextStyle(fontFamily: 'geb'),
                          ),
                          Gap(3),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Privacy()))
                            },
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontFamily: 'geb',
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Gap(3),
                          Text(
                            'and',
                            style: TextStyle(
                              fontFamily: 'geb',
                            ),
                          ),
                          Gap(3),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Terms()))
                            },
                            child: Text(
                              'Terms of Use',
                              style: TextStyle(
                                fontFamily: 'geb',
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Icon(Icons.check),
                      Gap(3),
                      Flexible(
                        child: Text(
                          'I hereby consent to the collection and processing of my personal data for the purpose of using the AI Autism Detection app.',
                          style: TextStyle(
                            fontFamily: 'geb',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneAuth()))
                    },
                    child: FullButton(
                      buttonText: 'Accept All',
                      buttonColor: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
