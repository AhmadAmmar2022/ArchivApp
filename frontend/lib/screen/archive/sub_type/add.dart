import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/main.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/globalfunctions.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomText.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../type/addtype.dart';
import '../type/viewtype.dart';
import 'view.dart';

class Add extends StatefulWidget {
  Add({super.key});
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController description = TextEditingController();
  // File? myfile;

  Request _request = Request();
  //List<PlatformFile>? _files;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  bool issigned = false;
  FilePickerResult? files;
  List<File> Allfiles = [];

  var fileTemporary;
  FilePickerResult? result; //
  List<PlatformFile> _images = [];
  List<File> _selectedImages = [];

  bool isloading = false;
  get getAppl => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add file"),
          backgroundColor: Color.fromRGBO(66, 96, 137, 1),
        ),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/7.jpg",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: [
              Row(children: [
                const SizedBox(
                  width: 280,
                ),
              ]),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 250, 251, 253),
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255), width: 0),
                ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(20),
                child: Form(
                    key: formstate,
                    child: Column(
                      children: [
                        CustomTextFild(
                          fillColor: Color(0xffADC0D4),
                          icon: Icon(Icons.person),
                          hint: " File name ",
                          controller: name,
                          onChanged: (val) {
                            return validate(val!, 25, 2);
                          },
                        ),
                        CustomTextFild(
                          fillColor: Color(0xffADC0D4),
                          icon: Icon(Icons.password),
                          hint: "Add date",
                          controller: date,
                          onChanged: (val) {
                            return validate(val!, 10, 2); //
                          },
                        ),
                        CustomTextFild(
                          fillColor: Color(0xffADC0D4),
                          icon: Icon(Icons.email),
                          hint: "Add description",
                          controller: description,
                          onChanged: (val) {
                            return validate(val!, 15, 2);
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 320,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 14, 0, 0), width: 1),
                            color: Color.fromARGB(255, 252, 252, 253),
                          ),
                          child: _selectedImages.isNotEmpty
                              ? GridView.builder(
                                  padding: EdgeInsets.all(8),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // عدد الأعمدة
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio:
                                        1, // يجعل الصور مربعة تقريباً
                                  ),
                                  itemCount: _selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        _selectedImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.cloud_upload),
                                      onPressed: () => _pickImages(),
                                      iconSize: 30,
                                    ),
                                    Text("Click here to choose a file or image")
                                  ],
                                )),

                          //
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomButton(
                          text: " Add ",
                          onPress: () async {
                            await _add();
                          },
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  Future<void> _add() async {
    print("==================>");
    _selectedImages.forEach((element) {
      print(element);
      print("==================>");
    });
    print("==================>");
    if (formstate.currentState!.validate()) {
      var response = await _request.postFile(
          AddSubTypeUrl,
          {
            "name": name.text,
            "date": date.text,
            "description": description.text,
            "type_id": Viewtype.type_id.toString()
          },
          _selectedImages);
      print("==========================");
      print(response);
      if (response != null && response['status'] == "success") {
        Get.snackbar(
          "${name.text}",
          "completed successfully",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        Get.to(() => Subtype());
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }

  Future<void> _pickImages() async {
    final List<XFile>? images = await ImagePicker()
        .pickMultiImage(); // Pick multiple images using ImagePicker

    if (images != null) {
      for (var image in images) {
        File file = File(image.path);
        setState(() {
          _selectedImages.add(file); // Add selected images to the list
        });
      }
    }
  }
}
