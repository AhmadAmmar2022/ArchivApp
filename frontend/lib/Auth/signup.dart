import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/linkes.dart';
import '../functions/globalfunctions.dart';
import '../functions/httpfunctions/Request.dart';
import '../widget/CustomText.dart';
import '../widget/CustomTextfild.dart';
import '../widget/customButton.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Request _request = Request();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/1.png"), // نفس خلفية login
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 300), // تعديل ارتفاع البدء
            Container(
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    CustomTextFild(
                      fillColor: Color(0xff838C96),
                      icon: Icon(Icons.person),
                      hint: "Username",
                      controller: username,
                      onChanged: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      fillColor: Color(0xff838C96),
                      icon: Icon(Icons.lock),
                      hint: "Password",
                      controller: password,
                      onChanged: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      fillColor: Color(0xff838C96),
                      icon: Icon(Icons.email),
                      hint: "Email",
                      controller: email,
                      onChanged: (val) {
                        return validate(val!, 15, 4);
                      },
                    ),
                    customText(
                      text: "Already have an account? ",
                      onPress: () {
                        Get.to(() => Login());
                      },
                    ),
                    CustomButton(
                      text: "Sign Up",
                      onPress: () async {
                        await signUp();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(SignUpUrl, {
        "username": username.text,
        "password": password.text,
        "email": email.text,
      });

      print(username.text);
      print(response);

      if (response['status'] == "success") {
        Get.snackbar(
          "${username.text}",
          "Sign up completed successfully",
          icon: Icon(Icons.check_circle, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        Get.to(() => Login());
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong, please try again",
          icon: Icon(Icons.error, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
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
