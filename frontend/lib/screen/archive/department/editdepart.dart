import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/archive/drawer/drawer.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/globalfunctions.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomText.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customButton.dart';

import '../type/addtype.dart';

class Editdepart extends StatefulWidget {
  final contract;
  Editdepart({super.key, required this.contract});
  @override
  _EditdepartState createState() => _EditdepartState();
}

class _EditdepartState extends State<Editdepart> {
  File? myfile;
  var response;

  TextEditingController name = TextEditingController();

  Request _request = Request();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  
  @override
  void initState() {
    setState(() {
      name.text = widget.contract["depart_name"];
    });
   

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
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      icon: Icon(Icons.person),
                      hint: "اسم القسم",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
                    CustomButton(
                      text: "  Editdepart ",
                      onPress: () async {
                        await Editdeparte();
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

  Editdeparte() async {
    if (formstate.currentState!.validate()) {
    response = await _request.postRequest(editDepartURL, {
      "depart_name": name.text.toString(),
      "depart_id": widget.contract["depart_id"].toString()
    });

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
       Get.to(() => drwer());
    } else {
      AlertDialog(
        title: Text("zzzzzzzz"),
      );
    }
  }
}
}