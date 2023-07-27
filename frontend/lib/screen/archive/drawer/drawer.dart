import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../department/viewdepart.dart';
import '../employees/employe.dart';
import '../type/homePage1.dart';
import '../type/viewtype.dart';
import 'Menutem.dart';

import 'munupage.dart';





class drwer extends StatefulWidget {
  const drwer({Key? key}) : super(key: key);

  @override
  State<drwer> createState() => _drwerState();
}

class _drwerState extends State<drwer> {
  final ZoomDrawerController z = ZoomDrawerController();
  // List<ScreenHiddenDrawer> _pages = [];
  final myTextstyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
  @override
  MenuItemm currentitem = MenuItems.employees;
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
        return Viewtype();
      case MenuItems.employees:
        return Viewdepart();
      case MenuItems.Finance:
        return Viewtype();
    }
    return Viewdepart();
  }
}
