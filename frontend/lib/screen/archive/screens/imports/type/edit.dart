import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../type/addtype.dart';

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

  @override
  void initState() {
    name.text = widget.contract["type_name"];
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.navigate_next_outlined))
        ],
        title: Text("تعديل"),
        backgroundColor: Color.fromRGBO(126, 95, 2, 1),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 213, 204, 204),
                border: Border.all(color: Colors.orange, width: 4),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            // color: Color.fromARGB(255, 182, 132, 114),
            padding: EdgeInsets.all(10),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    CustomTextFild(
                      icon: Icon(Icons.person),
                      hint: "اسم الجهة",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 204, 204),
                      ),
                      child: myfile == null
                          ? Image.network(
                              '$imageurl/${widget.contract["type_img"]}')
                          : Image.file(myfile!),
                    ),
                    CustomButton(
                      text: "Editimage",
                      onPress: () async {
                        await uploadImage();
                      },
                    ),
                  ],
                )),
          ),
          CustomButton(
            text: "EditType ",
            onPress: () async {
              await editTypee();
            },
          ),
        ],
      ),
    );
  }

  editTypee() async {
    if (formstate.currentState!.validate()) {
      if (myfile == null) {
        response = await _request.postRequest(editTypeURL, {
          "type_name":  name.text,
          "type_id"  :  widget.contract["type_id"].toString(),
          "type_img" :  widget.contract["type_img"].toString(),
        });
      } else {
          response = await _request.postFile(editTypeURL,{
          "type_name":   name.text.toString(),
          "type_id"  :   widget.contract["type_id"].toString(),
          "type_img" :   widget.contract["type_img"].toString(),
      },myfile!);
      }
      print(response);
      if (response['status'] == "success") {
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
}
