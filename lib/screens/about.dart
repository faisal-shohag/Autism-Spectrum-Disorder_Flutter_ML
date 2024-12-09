import 'package:asd/screens/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                Html(
                    data:
                        '<b>Website:</b> https://brur.ac.bd/<br><b>Email:</b> cse.zasim@gmail.com')
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
          ResearchAndInnovation(),
        ],
      ),
    );
  }
}

class ResearchAndInnovation extends StatelessWidget {
  // List of publications with title, source URL, and an optional accent color
  final List<Map<String, dynamic>> publications = [
    {
      'title': 'DL for Autism (EAAI 2024)',
      'source':
          'https://firebasestorage.googleapis.com/v0/b/asd-ml.appspot.com/o/proof_copy.pdf?alt=media&token=58f12f07-1421-44b1-8648-ab0c4b086f40',
      'color': Color(0xFF3498db), // Bright blue
    },
    {
      'title': 'DL for ASD and TD (IEEE SMC 2023)',
      'source':
          'https://firebasestorage.googleapis.com/v0/b/asd-ml.appspot.com/o/IEEE_SMC_2023.pdf?alt=media&token=6ec31e62-ba6b-4f84-ad45-7d457ed4a705',
      'color': Color(0xFFe74c3c), // Vibrant red
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Research & Innovation',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              'Vision',
              style: TextStyle(
                fontFamily: 'geb',
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Our vision is to create a world where every child has access to early detection of autism and other developmental disorders. We believe that by providing early intervention and early detection, we can make a difference in the lives of children with autism.',
              style: TextStyle(
                fontFamily: 'gsb',
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Publications',
              style: TextStyle(
                fontFamily: 'geb',
                fontSize: 15,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: publications.map((pub) {
                return _PublicationCard(
                  title: pub['title'],
                  source: pub['source'],
                  accentColor: pub['color'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PublicationCard extends StatelessWidget {
  final String title;
  final String source;
  final Color accentColor;

  const _PublicationCard({
    required this.title,
    required this.source,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withOpacity(0.1),
            accentColor.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => pdfView(
                  title: title,
                  source: source,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.description,
                      color: accentColor,
                      size: 40,
                    ),
                    Icon(
                      Icons.open_in_new,
                      color: accentColor.withOpacity(0.7),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'View Publication',
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
