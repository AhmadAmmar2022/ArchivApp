

import 'dart:io';

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

class Edit extends StatefulWidget {
  final contract;
  Edit({super.key,required this.contract});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
 
  var response;
  File? myfile;
    bool issigned=false;
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController salary = TextEditingController();
  Request _request = Request();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

    @override
    void initState() {
      name.text=widget.contract["contra_name"];
      date.text=widget.contract["contra_date"];
      salary.text=widget.contract["contra_salary"];
     
      
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "images/6.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child:ListView(
        children: [
          SizedBox(height: 100),
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
                    ),

                       Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 204, 204),
                      ),
                      child: myfile == null
                          ? Image.network(
                              '$imageurl/${widget.contract["contra_image"]}')
                          : Image.file(myfile!),
                    ),

                         InkWell(
                           child: Text(
                                  " اضغط هنا لتعديل صورة ",
                                  style: TextStyle(color: Color.fromARGB(255, 11, 53, 81)),
                                ),
                                onTap: () async{
                                         await uploadImage();
                                },
                         ),
                  
              
                    CustomButton(
                      text: "Edit ",
                      onPress: () async {
                        await editeData();
                      },
                    ),
                  
                  ],
                )),
          )
        ],
      ),
    ));
  }

      editeData() async {
      if (formstate.currentState!.validate()) {
         if (myfile==null)
         {
        response = await _request.postRequest(editSubType, {
        "contra_name": name.text,
        "contra_date":date.text,
        "contra_issigned":"1",
        "contra_salary":salary.text,
        "contra_image":widget.contract["contra_image"].toString(),
        "contra_id":widget.contract["contra_id"].toString(),
        "doc_id":Viewtype.type_id.toString()
        });
         }
         else {
       response = await _request.postFile(editSubType, {
        "contra_name": name.text,
        "contra_date":date.text,
        "contra_issigned":"1",
        "contra_salary":salary.text,
        "contra_image":widget.contract["contra_image"].toString(),
        "contra_id":widget.contract["contra_id"].toString(),
        "doc_id":Viewtype.type_id.toString()

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
