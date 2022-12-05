import 'package:flutter/material.dart';
import 'package:frontier/Auth/signup.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/homepage.dart';
import 'package:get/get.dart';

import '../const/linkes.dart';
import '../functions/globalfunctions.dart';
import '../functions/httpfunctions/Request.dart';
import '../widget/CustomText.dart';
import '../widget/CustomTextfild.dart';
import '../widget/customButton.dart';
import 'login.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username= TextEditingController();
  TextEditingController password= TextEditingController();
 
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Request _request= Request();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
       ListView(
        children: [
          SizedBox(height: 100),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 213, 204, 204),
                border: Border.all(color: Colors.orange, width: 4),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                      CustomTextFild(
                          icon: Icon(Icons.person),
                      hint: "username",
                      controller:username,
                      valu: (val) {
                        return validate(val!, 10, 4);
                      },
                    ),    
                     CustomTextFild(
                      icon: Icon(Icons.password),
                      hint: "password",
                      controller:password,
                      valu: (val) {
                        return validate(val!, 15, 4);
                      },
                    ),
                   customText(
                      onPress: () {
                        Get.to(SignUp());
                      },
                      text:"ifyou haven't account  ", 
                    ),
                        CustomButton(
                      text: "Login",
                      onPress: () async {
                        await login();
                      },
                    ),
                   
                  ],
                )),
          )
        ],
      )
    );
  }
  
  login() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(LoginUrl, {
        "username": username.text,
        "password": password.text,
      });
      if (response['status'] =="success") {
          sharedpref.setString("id",response['data']['id'].toString());
          sharedpref.setString("username",response['data']['username'].toString());
          sharedpref.setString("password",response['data']['password'].toString());
          print(sharedpref.getString("id"));
          print(response);
          Get.to(() => HomePage());
          Get.snackbar(
          "${username.text}",
          " Login completed successfully",
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

        Get.to(() => HomePage());
      } else {
             Get.snackbar(
          "Failure occurred",
          " The password or username is incorrect",
          icon: Icon(Icons.person, color: Colors.orange),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    }
  }
}
