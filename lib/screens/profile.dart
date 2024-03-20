import 'dart:io';
import 'package:asd/components/button.dart';
import 'package:asd/components/profileListItem.dart';
import 'package:asd/components/showCaseSmall.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/color.dart';
import 'package:asd/const/functions.dart';
import 'package:asd/screens/edit_profile.dart';
import 'package:asd/screens/info.dart';
import 'package:asd/services/authmiddle.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  File? PickedImage;
  bool isUploading = false;
  double? progress;
  String photoURL = "";

  Future<void> pickFromFile() async {
    final picker = ImagePicker();
    final pickedImg = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImg != null) {
      setState(() {
        PickedImage = File(pickedImg.path);
        isUploading = true;
      });
      uploadPhoto(PickedImage!);
    }
  }

  final metadata = SettableMetadata(contentType: "image/jpeg");
  final storageRef = FirebaseStorage.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;

  Future uploadPhoto(File imageFile) async {
    try {
      await storageRef
          .child('/profile_images/' + user.uid + ".jpg")
          .putFile(imageFile)
          .snapshotEvents
          .listen((event) async {
        switch (event.state) {
          case TaskState.running:
            print(
                "Uploading: ${100 * (event.bytesTransferred.toDouble() / event.totalBytes)}%");
            break;

          case TaskState.paused:
            break;
          case TaskState.success:
            final photo_url = await event.ref.getDownloadURL();
            // await FirebaseFirestore.instance
            //     .collection('users')
            //     .doc(user.uid)
            //     .update({"photoURL": photo_url});
            FirebaseAuth.instance.currentUser!.updatePhotoURL(photo_url);

            setState(() {
              isUploading = false;
              photoURL = photo_url;
            });
            print("Photo URL: ${photo_url}");
            print("Uploaded!");
            break;
          case TaskState.error:
            print("Error!");
            break;
          case TaskState.canceled:
            print("Canceled!");
            break;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser!.photoURL != null) {
      photoURL = (FirebaseAuth.instance.currentUser!.photoURL).toString();
    }
    // print(photoURL);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            ErrorSnackBar(context, snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          DocumentSnapshot<Map<String, dynamic>> userData = snapshot.data!;
          if (userData["info"] == false) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 40),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-1, -5),
                          blurRadius: 40,
                          color: Color.fromARGB(255, 131, 103, 231)
                              .withOpacity(0.3),
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
                  Divider(
                    height: 2,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideY(
                        duration: 500.ms,
                        begin: 0.2,
                      ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 30, right: 15),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                ),
                height: 100,
                width: 100,
                child: (photoURL == "")
                    ? CircleAvatar(
                        backgroundImage: AssetImage('assets/images/boy.png'),
                        child:
                            (isUploading) ? CircularProgressIndicator() : null,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(photoURL),
                        child:
                            (isUploading) ? CircularProgressIndicator() : null,
                      ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  )
                  .shimmer(duration: 2000.ms),
              SizedBox(
                height: 20,
              ),
              Text(
                userData["displayName"],
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'geb',
                  color: Colors.grey[700],
                ),
              ),
              Text(userData['email']),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InfoEdit()));
                    },
                    child: FlexButton(
                      width: 130,
                      prefixIcon: Remix.edit_box_line,
                      buttonText: 'Edit Profile',
                      buttonColor: Colors.green,
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      pickFromFile();
                    },
                    child: FlexButton(
                      width: 130,
                      prefixIcon: Remix.camera_3_fill,
                      buttonText: 'Photo',
                      buttonColor: Colors.pink,
                    ),
                  )
                ],
              ),
              Gap(20),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ShowCaseSmall(
                        val: calculateAge(userData["childAge"]).toString(),
                        title: 'Age',
                        color: colorRed),
                    Gap(10),
                    ShowCaseSmall(
                        val: centimetersToFeetAndInches(userData["height"]),
                        title: 'Height',
                        color: Colors.pink),
                    Gap(10),
                    ShowCaseSmall(
                        val: userData["weight"],
                        title: 'Weight(kg)',
                        color: Colors.amber),
                  ],
                ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideY(
                      duration: 500.ms,
                      begin: 0.2,
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 2,
                color: Colors.grey.shade200,
              ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/family.png',
                      title: userData["guardianName"],
                      subTitle: 'Guardian')
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/call.png',
                      title: '+8801318067123',
                      subTitle: 'Guardian Phone')
                  .animate(delay: 300.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/love.png',
                      title: userData['relationWith'],
                      subTitle: 'Relationship with guardian')
                  .animate(delay: 400.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/confetti.png',
                      title: formatDateString(userData['childAge']),
                      subTitle: 'Birthdate')
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 20,
              ),
              ProfileListItem(
                      img: 'assets/images/gender.png',
                      title: userData["gender"],
                      subTitle: 'Gender')
                  .animate(delay: 600.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 50,
              ),
              Divider(
                height: 2,
                color: Colors.grey.shade300,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AuthCheck()));
                },
                child: FlexButton(
                  width: 130,
                  prefixIcon: Remix.logout_box_line,
                  buttonText: 'Sign Out',
                  buttonColor: colorRed,
                ),
              ).animate(delay: 500.ms).fadeIn(duration: 500.ms).slideY(
                    duration: 500.ms,
                    begin: 0.2,
                  ),
              SizedBox(
                height: 50,
              ),
            ]),
          );
        },
      ),
    );
  }
}
