import 'package:flutter/material.dart';
import 'package:frontier/Auth/signup.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/archive/drawer/drawer.dart';
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
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Request _request = Request();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/1.png"), fit: BoxFit.fill),
      ),
      child: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(top: 350),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      CustomTextFild(
                        fillColor: Color(0xff838C96),
                        icon: Icon(Icons.person),
                        hint: "username",
                        controller: username,
                        onChanged: (val) {
                          return validate(val!, 10, 4);
                        },
                      ),
                      CustomTextFild(
                        fillColor: Color(0xff838C96),
                        icon: Icon(Icons.password),
                        hint: "password",
                        controller: password,
                        onChanged: (val) {
                          return validate(val!, 15, 4);
                        },
                      ),
                      CustomButton(
                        text: "Sign In",
                        onPress: () async {
                          await login();
                        },
                      ),
                    ],
                  )))
        ],
      ),
    ));
  }

  login() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(LoginUrl, {
        "username": username.text,
        "password": password.text,
      });
      if (response['status'] == "success") {
        sharedpref.setString(
            "username", response['data']['username'].toString());
        sharedpref.setString(
            "password", response['data']['password'].toString());
        sharedpref.setString("id", response['data']['id'].toString());

        print("=============================================>");
        print(sharedpref.getString("id"));
        print("=============================================>");
        Get.to(() => drwer());
        Get.snackbar(
          "${username.text}",
          " Login completed successfully",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );

        // Get.to(() => drawerimport());
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
