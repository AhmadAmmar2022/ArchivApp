import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../screen/archive/sub_type/view.dart';

class Request {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }
    } catch (e) {
      print("==========================>");
      print(e);
    }
  }

  postRequest(String url, Map data) async {
    var response = await http.post(Uri.parse(url), body: data);
    print("RAW RESPONSE: ${response.body}"); // أضف هذا

    if (response.statusCode == 200) {
      try {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } catch (e) {
        print("JSON Decode Error: $e");
        return null;
      }
    } else {
      print("Status Code: ${response.statusCode}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> postFile(
    String url,
    Map data,
    List<File> files, {
    String fileField = 'files[]', // ✅ هذا هو المطلوب
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // إضافة الملفات باستخدام الاسم المرسل
      for (var file in files) {
        request.files.add(
          await http.MultipartFile.fromPath(fileField, file.path),
        );
      }

      // إضافة باقي البيانات
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      print("RAW RESPONSE: ${responseBody.body}");

      if (response.statusCode == 200) {
        return jsonDecode(responseBody.body);
      } else {
        print('Error uploading files: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("Exception caught during file upload:");
      print(e);
      return null;
    }
  }
}
// }
//   Future<void> _sendFilesToServer(String url, Map data,List<String> paths) async {
//  request = http.MultipartRequest("POST", Uri.parse(url));

//   for (var path in paths) {
//     var file = await http.MultipartFile.fromPath('files[]', path);
//     request.files.add(file);
//   }
//     data.forEach((key, value) {
//     request.fields[key] = value;
//     });
//     var myrequest = await request.send();//
//    var response = await http.Response.fromStream(myrequest);
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     }
//     else {print("Eroor ${response.statusCode}");}
//     }
