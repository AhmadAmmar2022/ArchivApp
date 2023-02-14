import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/archive/screens/imports/type/viewtype.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/globalfunctions.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomText.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customButton.dart';

class Addtype extends StatefulWidget {
  Addtype({super.key});
  @override
  _AddtypeState createState() => _AddtypeState();
}

class _AddtypeState extends State<Addtype> {
  TextEditingController name = TextEditingController();
  Color color = Color(0xffa0c2f4);
  File? myfile;
  Request _request = Request();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
print("=====================>");

    return Scaffold(
        body:Container(
      decoration:const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "images/img.png",
            ),
            fit: BoxFit.fill),
      ),
      child: ListView(
        children: [
          Row(children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            ),
          const  SizedBox(
              width: 280,
            ),
            Image.asset("images/5.png")
          ]),
          Container(
            margin: EdgeInsets.fromLTRB(23, 80, 23, 0),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    CustomTextFild(
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      icon: Icon(Icons.person),
                      hint: "اسم المجلد",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
                 const   SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.folder),
                      color: color,
                      iconSize: 80,
                    )),
                    InkWell(
                      child: Text("اختر لون"),
                      onTap: () {
                        pickColor(context);
                      },
                    ),

                    CustomButton(
                      text: "  انشاء  ",
                      onPress: () async {
                        await Addtype();
                      },
                    ),
                    // CustomButton(
                    //   text: "selectimage",
                    //   onPress: () async {
                    //     await uploadImage();
                    //   },
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Color.fromARGB(255, 213, 204, 204),
                    //   ),
                    //   child: myfile == null
                    //       ? Text(
                    //           "No image selected",
                    //           style: TextStyle(color: Colors.blue),
                    //         )
                    //       : Image.file(myfile!),
                    // ),
                    // CustomButton(
                    //   text: "selectimage",
                    //   onPress: () async {
                    //     await uploadImage();
                    //   },
                    // ),
                    // CustomButton(
                    //   text: "Addtype",
                    //   onPress: () async {
                    //     await Addtype();
                    //   },
                    // ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

  Addtype() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(
          AddTypeUrl,
          {
            'type_name': name.text,
            'type_color':color.value.toString(),
          });
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
        Get.to(() => Viewtype());
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }

  Future uploadImage() async {
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

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('choose color '),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildColorPicker(),
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: Text("Select")),
              ],
            ),
          ));
  Widget buildColorPicker() => ColorPicker(
      pickerColor: color,
      onColorChanged: (color) => setState(() {
            this.color = color;
          }));
}
