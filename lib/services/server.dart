// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class BaseClient {
  String baseUrl = "http://7bc8-34-125-233-67.ngrok-free.app/";

  final dio = Dio();

  Future getFile() async {
    try {
      final picker = ImagePicker();
      var pickedFile = await picker.pickMedia();
      if (pickedFile == null) return null;
      File pfile = File(pickedFile.path);
      return {"file": pfile, "name": pfile.path.split('/').last};
    } on PlatformException catch (e) {
      debugPrint('Failed to get File: $e');
    }
  }

  Future upload(File file) async {
    String fileName = file.path.split('/').last;
    // var infoJson = json.encode(info);
    // var qJson = json.encode(questions);

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      // "info": infoJson,
      // "questions": qJson
    });
    // debugPrint(fileName);
    // debugPrint(infoJson.toString());

    String response = "";
    await dio
        .post("${baseUrl}upload", data: data)
        .then((res) => {response = res.toString()})
        .catchError((error) => {response = error.toString()});

    debugPrint('res: $response');

    return response;
  }
}
