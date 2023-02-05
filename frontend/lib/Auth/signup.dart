import 'package:flutter/material.dart';
import 'package:frontier/functions/httpfunctions/Request.dart';
import 'package:get/get.dart';

import '../const/linkes.dart';
import '../functions/globalfunctions.dart';
import '../widget/CustomText.dart';
import '../widget/CustomTextfild.dart';
import '../widget/customButton.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  Request _request = Request();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      hint: "username",
                      controller: username,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                        icon: Icon(Icons.password),
                      hint: "password",
                      controller: password,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      icon: Icon(Icons.email),
                      hint: "email",
                      controller: email,
                      valu: (val) {
                        return validate(val!, 15, 2);
                      },
                    ),
                        customText(
                      onPress: () {
                        Get.to(Login());
                      },
                      text:"if you have account  " ,
                    ),
                    CustomButton(
                      text: "Signup",
                      onPress: () async {
                        await signUp();
                      },
                    ),
                
                  ],
                )),
          )
        ],
      ),
    );
  }

  signUp() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(SignUpUrl, {
        "username": username.text,
        "email":    email.text,
        "password": password.text,
      });
      print(username);
      print(response);

      if (response['status'] == "success") {
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
        Get.to(() => Login());
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }
}
