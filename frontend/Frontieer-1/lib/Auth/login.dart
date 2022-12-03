

import 'package:flutter/material.dart';
import 'package:frontier/Auth/signup.dart';
import 'package:get/get.dart';

import 'login.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var myusername, mypassword ;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        children: [
          SizedBox(height: 100),
          Container(
  
            decoration: BoxDecoration( 
              color:Color.fromARGB(255, 213, 204, 204),
            border: Border.all(color:Colors.orange, width: 4),  
            borderRadius: BorderRadius.all(Radius.circular(20))  
             
          ),  

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
                            Text("if you haven't Account "),
                            InkWell(
                              onTap: () {
                                Get.to(SignUp());
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
                        Login();
                        print("===================");
                      },
                      child: Text(
                        "Login",
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

  Login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
    }
  }
}
