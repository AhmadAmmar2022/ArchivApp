import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/screen/archive/draweres/drawerimport/munupage.dart';
import 'package:frontier/screen/archive/screens/imports/type/viewtype.dart';

import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';



import '../../../homepage.dart';
import '../../screens/imports/sub_type/view.dart';

import '../unsigned.dart';
import 'Menutem.dart';

class drawerimport extends StatefulWidget {
  const drawerimport({Key? key}) : super(key: key);

  @override
  State<drawerimport> createState() => _drawerimportState();
}

class _drawerimportState extends State<drawerimport> {
  final ZoomDrawerController z = ZoomDrawerController();
  final myTextstyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
 @override
  MenuItemmImport currentitem = MenuItemImport.view;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      drawerShadowsBackgroundColor: Color.fromARGB(255, 5, 5, 5),
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
      case MenuItemImport.view:
        return Viewtype();
         case MenuItemImport.daily:
        return HomePage();
         case MenuItemImport.Unsigned_contracts:
        return unsigned();
    
    }
    return Viewtype();
  }
}
