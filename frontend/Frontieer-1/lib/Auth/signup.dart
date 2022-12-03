import 'package:flutter/material.dart';
import 'package:frontier/httpfunctions/Request.dart';
import 'package:get/get.dart';

import '../const/linkes.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var myusername, mypassword, myemail;
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
                    TextFormField(
                      onSaved: (val) {
                        myusername = val;
                      },
                      validator: (val) {
                        if (val!.length < 3) {
                          return "username must > 3 ";
                        }
                        if (val.isEmpty) {
                          return "username required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "username",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide:
                                  BorderSide(width: 5, color: Colors.red))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Email is required ";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length < 8) {
                          return "Password can't to be less than 8 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(width: 1))),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text("if you have Account "),
                            InkWell(
                              onTap: () {
                                Get.to(() => Login());
                              },
                              child: Text(
                                "Click Here",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )),
                    Container(
                        child: MaterialButton(
                      textColor: Colors.white,
                      color: Color.fromARGB(255, 252, 151, 0),
                      onPressed: () async {
                        signUpValid();
                        await signUp();
                        print("===================");
                      },
                      child: Text(
                        " sign up",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }

  signUpValid() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
    }
  }

  signUp() async {
    var response = await _request.postRequest(SignUpUrl, {
      "username": myusername.toString(),
      "email": myemail.toString(),
      "password": mypassword.toString()

    });
    print(response['status']);

    if (response['status'] == "success") {
      SnackBar(content: Text('success'));
      Get.to(Login());
    } else {
      AlertDialog(
        title: Text(""),
      );
    }
  }
}
