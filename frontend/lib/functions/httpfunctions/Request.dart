import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Request {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }
    } catch (e) {
      print("==========================");
      print(e);
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print("==========================>");
      print(e);
    }
  }

  postFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var length = await file.length();
    var streem = http.ByteStream(file.openRead());
    var multipartFil = http.MultipartFile("file", streem, length,
        filename: basename(file.path));
    request.files.add(multipartFil);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {print("Eroor ${response.statusCode}");}
  }
}
