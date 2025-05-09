import 'package:flutter/material.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/Auth/signup.dart';

import 'package:frontier/screen/homepage.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'screen/archive/drawer/drawer.dart';
import 'screen/archive/type/homePage1.dart';

late SharedPreferences sharedpref; //
var size, height, width; // Ahmad

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();

  // التحقق مما إذا كان المستخدم قد سجل الدخول بالفعل
  String? userId = sharedpref.getString("id");

  // بدء التطبيق بناءً على حالة تسجيل الدخول
  runApp(MyApp(isLoggedIn: userId != null && userId.isNotEmpty));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Almarai"),
      // إذا كان المستخدم مسجل، اذهب إلى الصفحة الرئيسية مع ZoomDrawer
      home: isLoggedIn ? drwer() : SignUp(),
    );
  }
}
