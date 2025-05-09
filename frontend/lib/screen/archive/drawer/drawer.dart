import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/screen/archive/sub_type/view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Auth/login.dart';
import '../../../Auth/signup.dart';

import 'Menutem.dart';
import 'munupage.dart';
import '../type/viewtype.dart'; // إضف تعديل إلى الصفحة التي تريد عرضها

class drwer extends StatefulWidget {
  const drwer({Key? key}) : super(key: key);

  @override
  State<drwer> createState() => _drwerState();
}

class _drwerState extends State<drwer> {
  final ZoomDrawerController z = ZoomDrawerController();
  MenuItemm currentitem = MenuItems.hompage;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  // التحقق من وجود حساب
  void checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("id");

    if (userId != null && userId.isNotEmpty) {
      // المستخدم مسجل الدخول بالفعل، انقلهم إلى الصفحة الرئيسية
      ZoomDrawer.of(context)!.toggle();
    } else {
      // لا يوجد حساب، انقلهم إلى صفحة تسجيل الدخول
      Get.to(() => Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      drawerShadowsBackgroundColor: Color.fromARGB(255, 80, 107, 156),
      menuScreenWidth: MediaQuery.of(context).size.width,
      style: DrawerStyle.defaultStyle,
      menuScreen: Builder(
        builder: (context) => MenuPage(
            currentitem: currentitem,
            onSelectedItem: (item) {
              setState(() {
                currentitem = item;
              });
              ZoomDrawer.of(context)!.close();
            }),
      ),
      angle: 0,
      mainScreen: getScreen(),
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      borderRadius: 50,
      showShadow: true,
    );
  }

  Widget getScreen() {
    switch (currentitem) {
      case MenuItems.hompage:
        return Viewtype(); // الصفحة الرئيسية التي تريدها
      case MenuItems.Appointment:
        return Subtype(); // عرض الأقسام
      case MenuItems.Finance:
        return Viewtype(); // أي صفحة أخرى ترغب في عرضها
      case MenuItems.Finance:
        return Subtype(); // صفحة التسجيل
    }
    return Viewtype();
  }
}
