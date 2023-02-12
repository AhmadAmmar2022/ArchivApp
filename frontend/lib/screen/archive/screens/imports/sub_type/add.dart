import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    bool issigned=false;
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
        title: Text("اضافة عقد"),
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
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
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
                    CustomTextFild(
                           fillColor: Color(0xff838C96),
                      icon: Icon(Icons.password),
                      hint: "تاريخ توقيع العقد ",
                      controller: date,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                           fillColor: Color(0xff838C96),
                      icon: Icon(Icons.email),
                      hint: "المبلغ",
                      controller: salary,
                      valu: (val) {
                        return validate(val!, 15, 2);
                      },
                    ),Row(children: [ Center(child: switcheadaptive()),Text(" هل العقد موقع ؟")]),
                    
                   SizedBox(height: 30,),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 213, 204, 204),
                      ),
                 child:myfile==null ?Text(" No image selected",style: TextStyle(color: Colors.blue),):Image.file(myfile!), 
                    ),
                    CustomButton(
                      text: "selectimage",
                      onPress: () async {
                        await uploadImage();
                    
                      },
                    ),
                    CustomButton(
                      text: "Add",
                      onPress: () async {
                        
                        await Add();
                      },
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Add() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postFile(AddUrl, {
        "contra_name": name.text,
        "contra_date": date.text,
        "contra_issigned":issigned? "1":"0",
        "contra_salary": salary.text,
        "doc_id":Viewtype.type_id.toString()
      },myfile!);
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
  Widget switcheadaptive() {
    return Switch(
      value:issigned,
      onChanged: (value) {
          setState(() {
            issigned=value;
          });
      },
    );
  }
  


}
