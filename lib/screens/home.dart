import 'package:asd/components/button.dart';
import 'package:asd/components/iconMenuItem.dart';
import 'package:asd/components/menutitle.dart';
import 'package:asd/const/detailsData.dart';
import 'package:asd/screens/blogDetails.dart';
import 'package:asd/screens/doctorZone/assignedDoctor.dart';
// import 'package:asd/screens/doctorZone/schedules.dart';
import 'package:asd/screens/info.dart';
import 'package:asd/screens/notifications.dart';
import 'package:asd/screens/ourself.dart';
import 'package:asd/screens/pdf_view.dart';
import 'package:asd/services/userinfo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:remixicon/remixicon.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final String html = r"""
<p>If your child has trouble falling asleep, sleeping through the night, waking
during the night and waking too early, these tips may help.</p>

<h2>How to establish a regular bedtime routine:</h2><ul>
<li>Start a short and predictable routine 15 to 30 minutes before bedtime. Use the
same order every night to help your child relax and get ready for sleep.</li>
<li>Place calm, soothing activities at the end of the routine, like reading a book with
dimmed lights.</li>
<li>Avoid stimulating activities, such as watching movies, playing video games or other
screen time activities as part of the routine. Try to avoid physical activities like running
or jumping 30 minutes before bedtime.</li>
<li>Consider creating visual supports, like a chart with pictures of your child’s bedtime
routine, to support and communicate your expectations around bedtime.</li>
</ul>

<h2>How to create a comfortable and consistent sleep environment:</h2><ul>
<li>Make sure your child’s sleeping space is not too hot or cold and keep the room
quiet and dark. Consider adding white noise if needed throughout the night.</li>
<li>Caregivers can add a night light if your child needs one, but leave the night light
on all night.</li>
<li>Consider adding heavy window coverings to block outside light.</li>
<li>Use materials for bedding and sleep clothes that work for your child’s preferences.</li>
</ul>

<h2>How to teach your child to fall asleep alone:</h2><ul>
<li>Caregivers should gradually fade out of the room. Try sitting on a chair by your
child’s bed instead of lying in the bed. Gradually move the chair further away from
the bed every few nights, with the ultimate goal to move the chair completely out
of the room.</li>
<li>Keep all interactions with your child brief and boring if you need to go back in the
room. For example, you can say, “You are ok, go to sleep,” and leave again.</li>
<li>Try to wait longer between each visit to the room.</li>
<li>Consider using a bedtime pass, which your child can exchange for one visit from
caregiver, a drink of water, or an extra hug or kiss.</li>
<li>You can also use these same strategies if your child calls out in the night for you.</li>
</ul>
  """;
  final List<String> imgList = [
    'assets/images/db1.jpg',
    'assets/images/db2.jpg',
    'assets/images/db3.jpg',
  ];

  Map<String, dynamic> userData = {};
  final user = FirebaseAuth.instance.currentUser!;
  bool isEdit = false;
  bool ntf = false;

  Future getUser() async {
    var data = await UserData().getDataFromFirestore(user.uid);

    setState(() {
      userData = data;
      isEdit = !userData["info"];
      // ntf = userData["ntf"];
    });
    // print(userData["displayName"]);
  }

  @override
  void initState() {
    getUser();
    super.initState();
    // Future.delayed(Duration(seconds: 3), () {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scale().animate().fadeIn(duration: 500.ms).slideY(
          //       duration: 500.ms,
          //       begin: 0.3,
          //     ),
          // SizedBox(
          //   height: 25,
          // ),
          // MenuTtitle(
          //   title: 'Blogs',
          // ),

          (isEdit == false)
              ? Column(
                  children: [
                    Container(
                      height: 40,
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
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(10, 10),
                            blurRadius: 20,
                            color: Color.fromARGB(255, 131, 103, 231)
                                .withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(
                        left: 3,
                        top: 10,
                        bottom: 4,
                        right: 20,
                      ),
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     colors: [
                      //       Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
                      //       Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
                      //     ],
                      //     begin: Alignment.bottomLeft,
                      //     end: Alignment.centerRight,
                      //   ),
                      //   borderRadius: BorderRadius.circular(20),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       offset: Offset(10, 10),
                      //       blurRadius: 20,
                      //       color: Color.fromARGB(255, 131, 103, 231)
                      //           .withOpacity(0.5),
                      //     ),
                      //   ],
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: FirebaseAuth
                                        .instance.currentUser!.photoURL !=
                                    null
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(FirebaseAuth
                                        .instance.currentUser!.photoURL
                                        .toString()),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/boy.png'),
                                  ),
                          ),
                          Gap(10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi,",
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${userData["displayName"]}',
                                style: TextStyle(
                                  fontFamily: 'geb',
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => Notifications()));
                          //   },
                          //   child: (ntf)
                          //       ? RippleAnimation(
                          //           color: Colors.white,
                          //           repeat: true,
                          //           minRadius: 30,
                          //           child: CircleAvatar(
                          //             child: Icon(
                          //               Remix.notification_4_fill,
                          //               size: 25,
                          //               color: Colors.black,
                          //             ),
                          //           ),
                          //         )
                          //       : CircleAvatar(
                          //           child: Icon(
                          //             Remix.notification_4_fill,
                          //             size: 25,
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          // )
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 40),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-1, -5),
                        blurRadius: 40,
                        color:
                            Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Remix.error_warning_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          Gap(10),
                          Text(
                            'Your profile is incomplete!',
                            style: TextStyle(
                              fontFamily: 'geb',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Some features may not be available!',
                        style: TextStyle(
                            fontFamily: 'gsb',
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoPage()));
                        },
                        child: FlexButton(
                          buttonColor: Colors.red,
                          buttonText: 'Edit Profile',
                        ),
                      ),
                    ],
                  ),
                ),
          Gap(20),
          CarouselSlider(
            items: imgList
                .map(
                  (item) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                              item,
                            ),
                            fit: BoxFit.cover)),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 150,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Gap(20),
          if ((userData["info"] == true))
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => AssignedDoctor()));
            //   },
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       MenuTtitle(
            //         title: 'Assigned Doctor',
            //       ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
            //             duration: 500.ms,
            //             begin: 0.3,
            //           ),
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         padding: EdgeInsets.all(10),
            //         margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           boxShadow: [
            //             BoxShadow(
            //               offset: Offset(2, 3),
            //               blurRadius: 20,
            //               color: Color.fromARGB(255, 131, 127, 127)
            //                   .withOpacity(0.2),
            //             ),
            //           ],
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             RippleAnimation(
            //               repeat: true,
            //               minRadius: 20,
            //               color: Colors.purple,
            //               child: CircleAvatar(
            //                 radius: 20,
            //                 backgroundImage: NetworkImage(
            //                     'https://www.felixhospital.com/sites/default/files/2022-11/dr-aditi-narad.jpg'),
            //               ),
            //             ),
            //             Gap(15),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Dr. Aditi Narad",
            //                   style: TextStyle(fontSize: 20, fontFamily: 'geb'),
            //                 ),
            //                 // Gap(5),
            //                 // Text(
            //                 //   'BASLP, MASLP',
            //                 //   style: TextStyle(
            //                 //     fontFamily: 'gsb',
            //                 //     fontSize: 16,
            //                 //   ),
            //                 // ),
            //                 // Text(
            //                 //   'Audiology & Speech Therapy',
            //                 //   style: TextStyle(
            //                 //     fontFamily: 'gsb',
            //                 //     fontSize: 14,
            //                 //   ),
            //                 // ),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Icon(
            //                       Remix.map_pin_2_fill,
            //                       size: 15,
            //                     ),
            //                     Gap(3),
            //                     Text(
            //                       'Rangpur',
            //                       style: TextStyle(
            //                         fontFamily: 'gsb',
            //                         fontSize: 13,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     MenuTtitle(
            //       title: 'Doctor zone',
            //     ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
            //           duration: 500.ms,
            //           begin: 0.3,
            //         ),
            //     Gap(5),
            //     Container(
            //       // width: MediaQuery.of(context).size.width,
            //       height: 50,
            //       child: ListView(
            //         scrollDirection: Axis.horizontal,
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               Navigator.of(context).pushNamed('/doctors');
            //             },
            //             child: SmallMenuCard(
            //               title: 'Doctors',
            //               menuIcon: FontAwesomeIcons.userDoctor,
            //             ),
            //           ),
            //           Gap(10),
            //           GestureDetector(
            //             onTap: () {
            //               Navigator.of(context).pushNamed('/schedules');
            //             },
            //             child: SmallMenuCard(
            //               title: 'Schedules',
            //               menuIcon: FontAwesomeIcons.calendarPlus,
            //             ),
            //           ),
            //           // Gap(10),
            //           // GestureDetector(
            //           //   onTap: () {
            //           //     Navigator.of(context).pushNamed('/docReports');
            //           //   },
            //           //   child: SmallMenuCard(
            //           //     title: 'Reports',
            //           //     menuIcon: FontAwesomeIcons.clipboard,
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //     ),
            //     Gap(20),
            //   ],
            // ),

            MenuTtitle(
              title: 'Ourself',
            ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
                  duration: 500.ms,
                  begin: 0.3,
                ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: IconMenuItem(
                    imageURL: 'https://i.postimg.cc/xCQBKtws/2390191.png',
                    title: 'Our Vision',
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OurSelf(title: 'Our Vision', index: 0)));
                  },
                ),
                GestureDetector(
                  child: IconMenuItem(
                    imageURL: 'https://i.postimg.cc/Qxg9mtK0/1055661.png',
                    title: 'Publications',
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => pdfView(
                            title: 'Publications',
                            source:
                                'https://firebasestorage.googleapis.com/v0/b/asd-ml.appspot.com/o/proof_copy.pdf?alt=media&token=58f12f07-1421-44b1-8648-ab0c4b086f40')));
                  },
                ),
                GestureDetector(
                  child: IconMenuItem(
                    imageURL: 'https://i.postimg.cc/c13TR4rk/2059784.png',
                    title: 'Data Policy',
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            OurSelf(title: 'Data Policy', index: 1)));
                  },
                ),
                GestureDetector(
                  child: IconMenuItem(
                    imageURL: 'https://i.postimg.cc/66gLgy3K/3306613.png',
                    title: 'About Us',
                  ),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         OurSelf(title: 'Our Vision', index: 0)));
                  },
                ),
              ],
            ),
          ),

          Gap(10),

          MenuTtitle(
            title: 'Do you know?',
          ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
                duration: 500.ms,
                begin: 0.3,
              ),

          Container(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlogDetails(
                          title: 'What is autism?',
                          img:
                              'https://carmenbpingree.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-13-at-4.30.12-PM.png',
                          pageData: autism,
                          author: 'AutismSpeaks',
                          designation: 'Organization',
                          authorImg:
                              'https://www.autismspeaks.org/themes/custom/particle/apps/drupal/logo_as.png',
                        ),
                      ),
                    );
                  },
                  child: LongMenuCard(
                    title: 'What is autism?',
                    img: 'assets/images/autism1.jpg',
                  ),
                ),
                Gap(10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlogDetails(
                          title: 'Sign of autism.',
                          img:
                              'https://1.bp.blogspot.com/-n7K3aT5MVms/UqNZ_xq3bpI/AAAAAAAAAFE/H5h3-RguKnc/s1600/Autism1.jpg',
                          pageData: soa,
                          author: 'AutismSpeaks',
                          designation: 'Organization',
                          authorImg:
                              'https://www.autismspeaks.org/themes/custom/particle/apps/drupal/logo_as.png',
                        ),
                      ),
                    );
                  },
                  child: LongMenuCard(
                    title: 'Sign of autism?',
                    img: 'assets/images/autism2b.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlogDetails(
                          title: 'How autism is treated?',
                          img:
                              'https://st.depositphotos.com/1189140/1955/i/450/depositphotos_19550919-stock-photo-pediatrician-doctor-and-patient-small.jpg',
                          pageData: treat,
                          author: 'Smitha Bhandari',
                          designation: 'MD',
                          authorImg:
                              'https://img.wbmdstatic.com/vim/live/webmd/consumer_assets/site_images/articles/biographies/bhandari_smitha_382x382.jpg',
                        ),
                      ),
                    );
                  },
                  child: LongMenuCard(
                    title: 'How autism is treated?',
                    img: 'assets/images/autism3b.jpg',
                  ),
                ),
              ],
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideY(
                duration: 500.ms,
                begin: 0.3,
              ),

          MenuTtitle(
            title: 'Guide to autism',
          ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideY(
                duration: 500.ms,
                begin: 0.3,
              ),
          Container(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => pdfView(
                          title: 'Parent\'s Guide to Autism',
                          source:
                              'https://www.autismspeaks.org/sites/default/files/2018-08/Parents%20Guide%20to%20Autism.pdf',
                        ),
                      ),
                    );
                  },
                  child: LongMenuCard2(
                    title: 'Parent\'s Guide',
                    img: 'assets/images/parentsb.jpg',
                  ),
                ),
                Gap(10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => pdfView(
                          title: 'Sibling\'s Guide to Autism',
                          source:
                              'https://www.autismspeaks.org/sites/default/files/2018-08/Siblings%20Guide%20to%20Autism.pdf',
                        ),
                      ),
                    );
                  },
                  child: LongMenuCard2(
                    title: 'Sibling\'s Guide',
                    img: 'assets/images/siblingsb.jpg',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => pdfView(
                          title: 'Friend\'s Guide to Autism',
                          source:
                              'https://www.autismspeaks.org/sites/default/files/Friends%20Guide%20to%20Autism.pdf',
                        ),
                      ),
                    );
                  },
                  child: LongMenuCard2(
                    title: 'Friend\'s   Guide',
                    img: 'assets/images/friendsb.jpg',
                  ),
                ),
              ],
            ),
          ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(
                duration: 500.ms,
                begin: 0.3,
              ),
          // Wrap(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.of(context)
          //             .push(MaterialPageRoute(builder: (context) => Doctor()));
          //       },
          //       child: MenuItem(
          //         menuIcon: Remix.stethoscope_line,
          //         menuTitle: 'Doctor',
          //         menuColor: Colors.green,
          //       ),
          //     ),
          //     MenuItem(
          //       menuIcon: Remix.parent_line,
          //       menuTitle: 'Parent',
          //       menuColor: Colors.purple,
          //     ),
          //   ],
          // )
          // MenuItem(
          //   menuIcon: Remix.hearts_line,
          //   menuTitle: 'Stories',
          //   menuColor: Colors.red,
          // ),
        ],
      ),
      onRefresh: () {
        print("Refresh");
        return Future.delayed(Duration(seconds: 1), () {
          getUser();
        });
      },
    );
  }
}

class SmallMenuCard extends StatelessWidget {
  final String title;
  final IconData menuIcon;
  const SmallMenuCard({
    super.key,
    required this.title,
    required this.menuIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 159, 22, 194).withOpacity(0.8),
            Color.fromARGB(255, 55, 39, 201).withOpacity(0.9),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(10, 10),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            menuIcon,
            size: 20,
            color: Colors.white,
          ),
          Gap(5),
          Text(
            title,
            style:
                TextStyle(fontFamily: 'gsb', fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class LongMenuCard2 extends StatelessWidget {
  final String title;
  final String img;
  const LongMenuCard2({
    super.key,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 140,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, -5),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
          ),
          Gap(10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'geb',
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class LongMenuCard extends StatelessWidget {
  final String title;
  final String img;
  const LongMenuCard({
    super.key,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 140,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, -5),
            blurRadius: 20,
            color: Color.fromARGB(255, 131, 103, 231).withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(10),
          CircleAvatar(
            backgroundImage: AssetImage(img),
            maxRadius: 50,
          ),
          Gap(5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'geb',
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}


// class Scale extends StatelessWidget {
//   const Scale({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       width: MediaQuery.of(context).size.width,
//       height: 100,
//       decoration: BoxDecoration(
//         color: color1.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Autism Severity Level',
//                 style: TextStyle(
//                   fontSize: 21,
//                   fontFamily: 'geb',
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 'Require Substantial Support',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: "geb",
//                   color: Colors.grey.shade500,
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: 80,
//             width: 75,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/polygon.png'),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 '2',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontFamily: 'geb',
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
