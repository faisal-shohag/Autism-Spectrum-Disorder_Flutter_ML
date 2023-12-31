// import 'package:asd/components/shadow_card3.dart';
import 'package:asd/screens/menu/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  List<Map<String, dynamic>> docs = [
    {
      "tag": "1",
      "location": "Rangpur",
      "name": "Dr. D K Gupta",
      "degree": "MBBS, MD",
      "speciality": "Paediatrics & Neonatology",
      "rating": 3.7,
      "image":
          "https://www.felixhospital.com/sites/default/files/2022-11/dr-dk-gupta.jpg",
      "details":
          "He has over 16 years of experience as a paediatrician and neonatology specialist. His area of expertise is infectious Diseases, General Paediatrics, Growth & Development. Consult him for any child/teenage issues related to Childhood illness, Immunization, Vaccination, Neonatal, and Child Growth and Development.",
    },
    {
      "tag": "2",
      "location": "Dhaka",
      "name": "Dr. Rashmi Gupta",
      "degree": "MBBS, DCH",
      "speciality": "Paediatrics & Neonatology",
      "rating": 4.1,
      "image":
          "https://www.felixhospital.com/sites/default/files/2022-11/dr-rashmi-gupta.jpg",
      "details":
          "Dr. Rashmi Gupta has over 16 years of experience as a pediatrician and neonatology specialist. Her area of expertise is infectious Diseases, General Paediatrics, Growth & Development. Consult her for any child/teenage issues related to Childhood illness, Immunization, Vaccination, Neonatal, and Child Growth and Development.",
    },
    {
      "tag": "3",
      "location": "Lalmonirhat",
      "name": "Dr. Soni Chaudhary",
      "degree": "BASLP, MASLP",
      "speciality": "Audiology & Speech Therapy",
      "rating": 3.5,
      "image":
          "https://www.felixhospital.com/sites/default/files/2022-11/dr-soni-chaudhary.jpg",
      "details":
          "Dr. Soni Chaudhary has over 14 years of experience as a speech therapist. Her area of expertise includes audiological diagnostic evaluation, child language disorder, fluency disorder, voice disorder, adult neuro communication disorder, aural rehabilitation, assessment of neurological language and speech disorder, hearing aid fittings, counseling. Consult her for any language and speech disorder issues for kids and adults.",
    },
    {
      "tag": "4",
      "location": "Gaibandha",
      "name": "Dr. Aditi Narad",
      "degree": "BDS, MDS",
      "speciality": "Dental Care",
      "rating": 4.0,
      "image":
          "https://www.felixhospital.com/sites/default/files/2022-11/dr-aditi-narad.jpg",
      "details":
          "Dr. Aditi Narad has over 10 years of experience as an endodontist. Her expertise includes endodontic surgeries, Single sitting RCT, Re-RCTs, Restoration of fracture teeth, filling teeth and eliminating decay, aesthetic cases (composite veneers, ceramic veneers, vital and non-vital bleaching), fabrication of all types of crowns and bridges, and full mouth rehabilitation. Consult her for any dental-related issues.",
    },
    {
      "tag": "5",
      "location": "Dhaka",
      "name": "Dr. Piyush Kumar Singh",
      "degree": "MBBS, D ORTHO, DNB, MNAMS",
      "speciality": "Orthopedics & Joint Replacement",
      "rating": 4.0,
      "image":
          "https://www.felixhospital.com/sites/default/files/2022-11/dr-piyush-kumar.jpg",
      "details":
          "Dr. Piyush Kumar Singh has over 14 years of experience as an orthopedician. He specializes in osteoporsis care, Osteoarthritis Care,  chronic low back pain, trauma care and all complex fracture. Consult him for any problem related to bones, joints, tendons, ligaments, and muscles.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Top(),
          // Gap(10),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorDetails(
                              tag: docs[index]["tag"],
                              imageUrl: docs[index]["image"],
                              name: docs[index]["name"],
                              details: docs[index]["details"],
                              rating: docs[index]["rating"],
                              location: docs[index]["location"],
                              speciality: docs[index]["speciality"],
                              degree: docs[index]["degree"],
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    // height: 70,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 3),
                          blurRadius: 20,
                          color: Color.fromARGB(255, 131, 127, 127)
                              .withOpacity(0.2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: docs[index]["tag"],
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: NetworkImage(docs[index]["image"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  docs[index]["name"],
                                  style: TextStyle(
                                    fontFamily: 'geb',
                                    fontSize: 20,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(docs[index]["speciality"]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                            allowHalfRating: true,
                                            glow: true,
                                            ignoreGestures: true,
                                            glowRadius: 10,
                                            glowColor: Color.fromARGB(
                                                255, 102, 52, 182),
                                            itemSize: 15,
                                            initialRating: docs[index]
                                                ["rating"],
                                            itemBuilder: (context, _) => Icon(
                                                  Remix.star_fill,
                                                  color: Color.fromARGB(
                                                      255, 102, 52, 182),
                                                ),
                                            onRatingUpdate: (rating) {}),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          docs[index]["rating"].toString(),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'gsb',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Remix.map_pin_2_fill,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Text(
                                            docs[index]["location"],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'gsb',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Remix.arrow_right_s_line,
                          size: 30,
                          color: Color.fromARGB(255, 102, 52, 182),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Top extends StatelessWidget {
  const Top({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 10, bottom: 10),
      margin: EdgeInsets.only(bottom: 0),
      // height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
            Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 20,
                    color: Color.fromARGB(68, 17, 17, 17),
                  ),
                ],
              ),
              child: Icon(Remix.arrow_left_s_line),
            ),
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/doctors.png',
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Experts',
                  style: TextStyle(
                    fontFamily: 'geb',
                    color: Colors.grey.shade100,
                    fontSize: 30,
                  ),
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
