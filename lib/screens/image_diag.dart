import 'dart:convert';
import 'dart:io';

import 'package:asd/components/button.dart';
// import 'package:asd/components/diagnosis_form.dart';
import 'package:asd/components/snackBars.dart';
import 'package:asd/const/color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  String base64Image = "";
  int resState = 0;

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

  Future<void> Predict(XFile imagePath) async {
    final dio = Dio();
    final url = 'http://4f07-34-73-93-190.ngrok-free.app/upload';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imagePath.path),
    });

    try {
      final response = await dio.post(url, data: formData);
      print('---------Response Code: ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          result = data['res'];
          base64Image = data['img'];
          isClickPredict = false;
          resState = 200;
        });
      } else {
        setState(() {
          result = response.data;
          base64Image = '';
          isClickPredict = false;
          resState = 404;
        });
      }
    } catch (e) {
      setState(() {
        isClickPredict = false;
        result = 'No face was detected!';
        resState = 404;

        debugPrint(e.toString());
      });
    }
  }

  @override
  void dispose() {
    PickedImage = null;
    isClickPredict = false;
    filename = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Diagnosis',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                const SizedBox(
                  height: 20,
                ),
                if (PickedImage != null)
                  Container(
                    height: 150,
                    // width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: [
                      //   BoxShadow(
                      //     offset: Offset(1, 5),
                      //     blurRadius: 5,
                      //     color: Color.fromARGB(255, 131, 103, 231)
                      //         .withOpacity(0.3),
                      //   ),
                      // ],
                      image: DecorationImage(
                        image: FileImage(PickedImage as File),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
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
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            filename,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    debugPrint('Predict');

                    if (PickedImage == null) {
                      ErrorSnackBar(context, 'Please Pick an Image First!');
                    } else {
                      setState(() {
                        isClickPredict = true;
                        resState = 0;
                      });

                      await Predict(picked as XFile);
                    }
                  },
                  child: FlexButton(
                    buttonText: 'Predict',
                    buttonColor: color2.withOpacity(1),
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (isClickPredict) CircularProgressIndicator(),
                if (isClickPredict)
                  SizedBox(
                    height: 20,
                  ),
                (resState == 200)
                    ? Image.memory(
                        Base64Decoder().convert(base64Image),
                        height: 150,
                      )
                    : Text(''),
                SizedBox(
                  height: 20,
                ),
                (resState == 200)
                    ? Text(
                        result,
                        style: TextStyle(
                          fontFamily: 'geb',
                          fontSize: 20,
                        ),
                      )
                    : Text(''),
                (resState == 404)
                    ? Text(
                        result,
                        style: TextStyle(
                          fontFamily: 'geb',
                          fontSize: 20,
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
