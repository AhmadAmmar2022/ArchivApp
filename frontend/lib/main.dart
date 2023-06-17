import 'package:flutter/material.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/Auth/signup.dart';
import 'package:frontier/screen/archive/draweres/drawerimport/drawerimport.dart';
import 'package:frontier/screen/archive/screens/imports/type/viewtype.dart';
import 'package:frontier/screen/homepage.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;
var size, height, width;// Ahmad 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Almarai"
        ),
        home: Viewtype());
  }
}
