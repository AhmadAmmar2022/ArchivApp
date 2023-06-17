import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

   Future  postFile(String url, Map data, List<File> files) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      for (var file in files) {
        // var stream = http.ByteStream(file.openRead());
        //  var length = await file.length();
        //  var streem = http.ByteStream(file.openRead());//open

        request.files
            .add(await http.MultipartFile.fromPath('files[]', file.path));
      }
        data.forEach((key, value) {
        request.fields[key] = value;
        });

      //  var multipartFil = await http.MultipartFile('file', stream, length, filename: file.path.split('/').last);
      //  request.files.add(multipartFil);
      
      // var myrequest = await request.send();
      // var response = await http.Response.fromStream(myrequest);//
      // if (response.statusCode == 200) {
      //   return jsonDecode(response.body);
      // }
      // else {print("Eroor ${response.statusCode}");

      // }
    var response = await request.send(); //
       
      if (response.statusCode==200) {
        print('Files uploaded successfully!');
      } else {
        print('Error uploading files: ${response.statusCode}');
      }
    } catch (e) {
      print("========================>"); 
      print(e);
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
