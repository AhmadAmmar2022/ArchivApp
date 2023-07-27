import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
import 'viewtype.dart';

class EditType extends StatefulWidget {
  final contract;
  EditType({super.key, required this.contract});
  @override
  _EditTypeState createState() => _EditTypeState();
}

class _EditTypeState extends State<EditType> {
  File? myfile;
  var response;
  
  TextEditingController name = TextEditingController();

  Request _request = Request();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  late Color color ;
  @override
  void initState() {
    
    setState(() {
      color=Color(int.parse(widget.contract["type_color"]));
    });
    name.text = widget.contract["type_name"];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/6.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: ListView(
        children: [
          Container(
            height: 300,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromARGB(255, 250, 251, 253),
              border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), width: 0),
            ),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextFild(
                      fillColor: Color(0xff838C96),
                      icon: Icon(Icons.person),
                      hint: "اسم الجهة",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
                        Container(
                        child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.folder),
                      color: color,
                      iconSize: 80,
                    )),
                    InkWell(
                      child: Center(child: Text(" تغيير اللون")),
                      onTap: () {
                        pickColor(context);
                      },
                    ),
                    CustomButton(
                      text: "  EditType ",
                      onPress: () async {
                        await editTypee();
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

  editTypee() async {
    // if (formstate.currentState!.validate()) {
      response = await _request.postRequest(editTypeURL, {
        "type_name": name.text,
        "type_id" : widget.contract["type_id"].toString(),
        "type_color":color.value.toString(),
      });

      print(response);
      if (response['status'] =="success") {
        Get.snackbar(
          "${name.text}",
          "update successfully",
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


   void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('choose color '),
            content: SingleChildScrollView(
              child: Column(
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
            ),
          ));
  Widget buildColorPicker() => ColorPicker(
      pickerColor: color,
      onColorChanged: (color) => setState(() {
            this.color = color;
          }));
}
