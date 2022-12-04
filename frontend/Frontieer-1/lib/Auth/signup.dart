import 'package:flutter/material.dart';
import 'package:frontier/functions/httpfunctions/Request.dart';
import 'package:get/get.dart';

import '../const/linkes.dart';
import '../functions/globalfunctions.dart';
import '../widget/CustomTextfild.dart';
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
                      hint: "username",
                      controller: username,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      hint: "password",
                      controller: password,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      hint: "email",
                      controller: email,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    // CustomTextFild("username", Icons.person),
                    // SizedBox(height: 20),
                    // CustomTextFild("email", Icons.email),
                    // SizedBox(height: 20),
                    // CustomTextFild("password", Icons.password),
                    // SizedBox(height: 20),
                    // CustomText(),
                    // SizedBox(height: 20),
                    CustomButtos(),
                  ],
                )),
          )
        ],
      ),
    );
  }

  // custom widget--------------------------------------------------------------------------------------------------------
  Widget CustomButtos() {
    return Container(
        child: MaterialButton(
      textColor: Colors.white,
      color: Color.fromARGB(255, 252, 151, 0),
      onPressed: () async {
        await signUp();
      },
      child: Text(
        " sign up",
        style: Theme.of(context).textTheme.headline6,
      ),
    ));
  }

  // Widget CustomTextFild(String st, IconData iconbutton) {
  //   return TextFormField(
  //     onSaved: (val) {
  //       if (st == "username") {
  //         myusername = val;
  //       } else if (st == "password") {
  //         mypassword = val;
  //       } else {
  //         myemail = val;
  //       }
  //     },
  //     validator: (val) {
  //       if (val!.length < 3) {
  //         return "$st must > 3 ";
  //       }
  //       if (val.isEmpty) {
  //         return "$st required";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.person),
  //         hintText: "$st",
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(15.0)),
  //             borderSide: BorderSide(width: 5, color: Colors.red))),
  //   );
  // }

  // Widget CustomText() {
  //   return Container(
  //       margin: EdgeInsets.all(10),
  //       child: Row(
  //         children: [
  //           Text("if you have Account "),
  //           InkWell(
  //             onTap: () {
  //               Get.to(() => Login());
  //             },
  //             child: Text(
  //               "Click Here",
  //               style: TextStyle(color: Colors.blue),
  //             ),
  //           )
  //         ],
  //       ));
  // }

  // Functions---------------------------------------------------------------------------------------------------------
  signUpValid() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
    }
  }

  signUp() async {
    if (formstate.currentState!.validate()) {
      var response = await _request.postRequest(SignUpUrl, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
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
        await Future.delayed(Duration(seconds: 2));
        Get.to(() => Login());
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }
}
