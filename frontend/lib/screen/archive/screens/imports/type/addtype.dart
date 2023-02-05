import 'dart:io';
import 'dart:ui';

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

class Addtype extends StatefulWidget {
  Addtype({super.key});
  @override
  _AddtypeState createState() => _AddtypeState();
}

class _AddtypeState extends State<Addtype> {
  TextEditingController name = TextEditingController();
 
  File? myfile;
  Request _request = Request();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
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
        title: Text("اضافة عقد "),
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
                      icon: Icon(Icons.person),
                      hint: "اسم الجهة",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
              SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 213, 204, 204),
                      ),
                 child:myfile==null ?Text("No image selected",style: TextStyle(color: Colors.blue),):Image.file(myfile!), 
                    ),
                    CustomButton(
                      text: "selectimage",
                      onPress: () async {
                        await uploadImage();
                      },
                    ),
                    CustomButton(
                      text: "Addtype",
                      onPress: () async {
                        await Addtype();
                      },
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Addtype() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postFile(AddTypeUrl,{
        "type_name": name.text,
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
      print("================================");
      print(e);
    }
  }

}
