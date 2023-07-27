import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontier/widget/CustomTextfild.dart';
import 'package:get/get.dart';

import '../../../const/linkes.dart';
import '../../../functions/globalfunctions.dart';
import '../../../functions/httpfunctions/Request.dart';
import '../../../main.dart';
import '../../../widget/customButton.dart';
import '../drawer/drawer.dart';
import '../type/addtype.dart';
import 'viewdepart.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({super.key});

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
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
        body: Container(
      height: size.height,
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
          Row(children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // ZoomDrawer.of(context)!.toggle();
              },
            ),
            const SizedBox(
              width: 280,
            ),
            Image.asset("images/5.png")
          ]),
          Container(
            margin: EdgeInsets.fromLTRB(23, 80, 23, 0),
            child: Form(
                key: formstate,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(141, 255, 254, 254),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromARGB(171, 248, 248, 248),
                        // offset: new Offset(6.0, 6.0),
                      ),
                    ],
                  ),
                  child: Column(
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
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        text: "  انشاء  ",
                        onPress: () async {
                          await addDepartment();
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
                  ),
                )),
          ),
        ],
      ),
    ));
  }
  addDepartment() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(
          AddDepertURl,
          {
            'type_name': name.text,
           
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
         Get.to(() => drwer());
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }
}
