

import 'package:flutter/material.dart';
import 'package:frontier/main.dart';

import 'package:get/get.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/globalfunctions.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomText.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customButton.dart';

import 'view.dart';

class Edit extends StatefulWidget {
  final contract;
  Edit({super.key,required this.contract});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  var id ;
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
      appBar: AppBar(actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.navigate_next_outlined))
            ],
            title: Text("تعديل  "),
            backgroundColor: Color.fromRGBO(126, 95, 2, 1),),
      body: ListView(
        children: [
          SizedBox(height: 100),
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
                    CustomTextFild(
                        icon: Icon(Icons.password),
                      hint: "تاريخ توقيع العقد ",
                      controller: date,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      icon: Icon(Icons.email),
                      hint: "المبلغ",
                      controller: salary,
                      valu: (val) {
                        return validate(val!, 15, 2);
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
    );
  }

      editeData() async {
      if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(AddUrl, {
        "contra_name": name.text,
        "contra_date":date.text,
        "contra_issigned":"0",
        "contra_salary":salary.text,
        "user_id":sharedpref.get('id'),
      });
      print(response);
      if (response['status'] =="success") {
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
      
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }

}
