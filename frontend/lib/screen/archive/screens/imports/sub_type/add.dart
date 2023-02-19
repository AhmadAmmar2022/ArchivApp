import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/main.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/globalfunctions.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomText.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customButton.dart';

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
  TextEditingController salary = TextEditingController();
  File? myfile;
  Request _request = Request();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  bool issigned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              color: Colors.white,
            ),
            const SizedBox(
              width: 280,
            ),
            Image.asset("images/5.png")
          ]),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
                      hint: "اسم الجهة",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
                    CustomTextFild(
                      fillColor: Color(0xffADC0D4),
                      icon: Icon(Icons.password),
                      hint: "تاريخ توقيع العقد ",
                      controller: date,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                 
                  
                    CustomTextFild(
                      fillColor: Color(0xffADC0D4),
                      icon: Icon(Icons.email),
                      hint: "المبلغ",
                      controller: salary,
                      valu: (val) {
                        return validate(val!, 15, 2);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        color: Color.fromARGB(255, 252, 252, 253),
                      ),
                      child: myfile == null
                          ? InkWell(
                            child: Text(
                                " اضغط هنا لارفاق ملف ",
                                style: TextStyle(color: Color.fromARGB(255, 11, 53, 81)),
                              ),
                              onTap:()=>_showBottomSheet(),
                          )
                          : Image.file(myfile!),
                    ),
                 
                    CustomButton(
                      text: " اضافة ",
                      onPress: () async {
                        await Add();
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

  Add() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postFile(
          AddSubTypeUrl,
          {
            "contra_name": name.text,
            "contra_date": date.text,
            "contra_issigned": "1",
            "contra_salary": salary.text,
            "doc_id": Viewtype.type_id.toString()
          },
          myfile!);
      print(response);
      if (response['status'] == "success") {
        Get.snackbar(
          "${name.text}",
          "  completed successfully",
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

  Future uploadImageFromCamira() async {
    try {
      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        myfile = File(xfile!.path);
      });
    } on PlatformException catch (e) {
      print("================================>");
      print(e);
    }
  }
    Future uploadImageFromGallary() async {
    try {
      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        myfile = File(xfile!.path);
      });
    } on PlatformException catch (e) {
      print("================================>");
      print(e);
    }
  }

  Widget switcheadaptive() {
    return Switch(
      value: issigned,
      onChanged: (value) {
        setState(() {
          issigned = value;
        });
      },
    );
  }
  _showBottomSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Color(0xFF5C81AC),
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  " اختيار صورة من",
                  style: TextStyle(
                      color: Color.fromARGB(255, 247, 248, 249), fontSize: 20),
                ),
                Container(
                  child: ListTile(
                    title: Text("المعرض"),
                    leading: Icon(Icons.image),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await uploadImageFromGallary();
          
                    },
                  ),
                ),
                Container(
                  child: ListTile(
                    title: Text("الكميرا"),
                    leading: Icon(Icons.camera),
                    onTap: () async {
                        Navigator.of(context).pop();
                      await uploadImageFromCamira();
                    
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
  
}
