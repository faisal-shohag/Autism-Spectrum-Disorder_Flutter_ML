import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:asd/components/button.dart';
import 'package:asd/components/iconMenuItem.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/RegEx.dart';
import 'package:asd/screens/ourself.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';

class ImageDiagnosis extends StatefulWidget {
  const ImageDiagnosis({super.key});

  @override
  State<ImageDiagnosis> createState() => _ImageDiagnosisState();
}

class _ImageDiagnosisState extends State<ImageDiagnosis> {
  File? PickedImage;
  String filename = "";
  bool isClickPredict = false;
  XFile? picked;
  String result = "";
  dynamic prediction_data;
  String base64Image = "";
  int resState = 0;
  bool isUploading = false;
  double? progress;
  final String serverURL = "https://living-shark-hopelessly.ngrok-free.app";

  // Pick image from memory
  Future<void> pickFromFile() async {
    final picker = ImagePicker();
    final pickedImg = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImg != null) {
      setState(() {
        PickedImage = File(pickedImg.path);
        filename = pickedImg.path.split('/').last;
        picked = pickedImg;
      });
    }
  }

  // Pick image from memory
  Future<void> pickFromCamera() async {
    final picker = ImagePicker();
    final pickedImg = await picker.pickImage(source: ImageSource.camera);
    if (pickedImg != null) {
      setState(() {
        PickedImage = File(pickedImg.path);
        filename = pickedImg.path.split('/').last;
        picked = pickedImg;
      });
    }
  }

  Future<void> Predict(XFile imagePath, String server_url) async {
    final dio = Dio();
    final url = '$server_url/upload';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath.path),
    });

    try {
      final response = await dio.post(url, data: formData);
      print('---------Response Code: ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          prediction_data = data;
          // print(prediction_data);
          result = data['res'];
          base64Image = data['img'];
          // isClickPredict = false;
          resState = 200;
        });
        uploadPhoto(base64Image);
      } else {
        setState(() {
          result = response.data;
          base64Image = '';
          isClickPredict = false;
          resState = 404;
          print(response);
          ErrorSnackBar(context, response.data);
        });
      }
    } on DioException catch (e) {
      setState(() {
        isClickPredict = false;
        result = 'No face was detected!';
        resState = 404;
        print(e);

        debugPrint(e.toString());
      });
    }
  }

  final metadata = SettableMetadata(contentType: "image/jpeg");
  final storageRef = FirebaseStorage.instance.ref();
  final user = FirebaseAuth.instance.currentUser!;
  Future uploadPhoto(String imageData) async {
    setState(() {
      isUploading = true;
    });
    try {
      Uint8List bytes = base64.decode(imageData);

      await storageRef
          .child('/predict_images/' + user.uid + ".jpg")
          .putData(bytes)
          .snapshotEvents
          .listen((event) async {
        switch (event.state) {
          case TaskState.running:
            setState(() {
              progress =
                  100 * (event.bytesTransferred.toDouble() / event.totalBytes);
            });
            print(
                "Uploading: ${100 * (event.bytesTransferred.toDouble() / event.totalBytes)}%");
            break;

          case TaskState.paused:
            break;
          case TaskState.success:
            final photo_url = await event.ref.getDownloadURL();
            print("Photo URL: ${photo_url}");
            print("Uploaded!");
            delayedFunction(() async {
              await FirebaseFirestore.instance
                  .collection('image_prediction')
                  .doc(user.uid)
                  .set({
                "photoURL": photo_url,
                "result": result,
                "prediction_data": {
                  "probabilities": prediction_data["probabilities"],
                  "class": prediction_data["class"]
                }
              });
              setState(() {
                isUploading = false;
                isClickPredict = false;
              });
            }, Duration(seconds: 5));

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

  Future<void> delayedFunction(Function() callback, Duration duration) async {
    await Future.delayed(duration);
    callback();
  }

  @override
  void dispose() {
    PickedImage = null;
    isClickPredict = false;
    isUploading = false;
    filename = "";
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Remix.arrow_left_s_line,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          'Test with AI model',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('image_prediction')
            .doc(user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.exists) {
            dynamic pred_data = snapshot.data!["prediction_data"];
            // int pred_class = pred_data["class"];
            List<dynamic> prob = pred_data["probabilities"];

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(0.8),
                  child: Column(
                    children: [
                      Gap(15),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!["photoURL"])),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                            width: 5.0,
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  (prob[0] * 100).toStringAsFixed(2) + '%',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'geb'),
                                ),
                                Text(
                                  "Autistic",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontFamily: 'gsb'),
                                ),
                              ],
                            ),
                          ),
                          Gap(20),
                          Container(
                            width: 90,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  (prob[1] * 100).toStringAsFixed(2) + '%',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'geb'),
                                ),
                                Text(
                                  "Non-autistic",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontFamily: 'gsb'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      //based on non autistic
                      Text(
                        'Status: ${(prob[1] * 100).toInt() > 69 ? 'Safe' : (prob[1] * 100).toInt() > 59 ? 'Moderate' : 'Severe'}',
                        style: TextStyle(
                          fontFamily: 'geb',
                          fontSize: 19,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (snapshot.data!["result"] == "Autistic")
                              ? Colors.pink.shade200
                              : Colors.green.shade200,
                        ),
                        child: (snapshot.data!["result"] == "Autistic")
                            ? Text(
                                'This result indicates that the child has symptoms of autism. We suggest expert\'s diagnosis for further evaluation. This result is generated by ML model.',
                                style: TextStyle(
                                  fontFamily: 'gsb',
                                  fontSize: 17,
                                ),
                              )
                            : Text(
                                'This result indicates that your child is safe from autism. This result is generated by ML model. Sometimes the result can be ambigious and misleading. Do not depend on this result only.',
                                style: TextStyle(
                                  fontFamily: 'gsb',
                                  fontSize: 17,
                                ),
                              ),
                      ),
                      // Gap(10),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 20,
                      //     right: 20,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       GestureDetector(
                      //         child: IconMenuItem(
                      //           imageURL:
                      //               'https://i.postimg.cc/66gLgy3K/3306613.png',
                      //           title: 'About Result',
                      //         ),
                      //         onTap: () {
                      //           Navigator.of(context).push(MaterialPageRoute(
                      //               builder: (context) => OurSelf(
                      //                   title: 'About the result', index: 2)));
                      //         },
                      //       ),
                      //       Gap(30),
                      //       GestureDetector(
                      //         child: IconMenuItem(
                      //           imageURL:
                      //               'https://i.postimg.cc/c13TR4rk/2059784.png',
                      //           title: 'Data Policy',
                      //         ),
                      //         onTap: () {
                      //           Navigator.of(context).push(MaterialPageRoute(
                      //               builder: (context) => OurSelf(
                      //                   title: 'Data Policy', index: 1)));
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Gap(20),
                      GestureDetector(
                        onTap: () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.noHeader,
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Really?',
                              desc: 'This result will be deleted!',
                              buttonsTextStyle:
                                  const TextStyle(color: Colors.black),
                              showCloseIcon: false,
                              btnOkText: "OK",
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('image_prediction')
                                    .doc(user.uid)
                                    .delete();
                                setState(() {
                                  result = "";
                                  isUploading = false;
                                  isClickPredict = false;
                                  progress = null;
                                });
                                SuccessSnackBar(
                                    context, 'Test has been reset!');
                              }).show();
                        },
                        child: FlexButton(
                          width: 200,
                          prefixIcon: Remix.refresh_line,
                          buttonColor: Colors.black,
                          buttonText: "Reset & Test Again",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (isClickPredict == false)
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/upload.png',
                            height: 150.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink),
                                onPressed: () async {
                                  await pickFromFile();
                                },
                                icon: const Icon(
                                  Remix.image_add_fill,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink),
                                onPressed: () async {
                                  await pickFromCamera();
                                },
                                icon: const Icon(
                                  Remix.camera_2_fill,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Camera',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Gap(20),
                        ],
                      ),
                    if (PickedImage != null)
                      SizedBox(
                        height: 150,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(PickedImage as File),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    if (isClickPredict == false)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (filename != "")
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Remix.image_fill),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Text(
                                      filename,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Gap(20),
                          GestureDetector(
                            onTap: () async {
                              debugPrint('Predict');

                              if (PickedImage == null) {
                                ErrorSnackBar(
                                    context, 'Please Pick an Image First!');
                              } else if (serverURL == "" ||
                                  !urlRegExp.hasMatch(serverURL)) {
                                ErrorSnackBar(context,
                                    'Please provide valid server URL!');
                              } else {
                                setState(() {
                                  isClickPredict = true;
                                  resState = 0;
                                });

                                await Predict(picked as XFile, serverURL);
                              }
                            },
                            child: (PickedImage == null)
                                ? Text(
                                    'Please select an Image from folder or capture from camera. Image should have clear and full face view.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'geb',
                                      color: Colors.pink,
                                    ),
                                  )
                                : FlexButton(
                                    prefixIcon: Remix.play_line,
                                    buttonText: 'Start Test',
                                    width: 180,
                                    buttonColor: Colors.black,
                                    // width: 100,
                                  ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (isClickPredict)
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Gap(5),
                              Text(
                                "Testing...Please wait...",
                                style: TextStyle(fontFamily: 'geb'),
                              ),
                              Gap(10),
                              Text(
                                'Please do not close the app or this screen!',
                                style: TextStyle(
                                    color: Colors.red, fontFamily: 'geb'),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
