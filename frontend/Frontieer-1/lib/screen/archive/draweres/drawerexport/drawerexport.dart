import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/screen/archive/draweres/drawerexport/Menutemexport.dart';
import 'package:frontier/screen/archive/draweres/drawerexport/munupageexport.dart';
import 'package:frontier/screen/archive/screens/exports/daily.dart';
import 'package:frontier/screen/archive/screens/exports/logistical.dart';
import 'package:frontier/screen/archive/screens/exports/rewards.dart';

import '../../../BottomNavigationBar.dart';


class drawerexport extends StatefulWidget {
  const drawerexport({Key? key}) : super(key: key);

  @override
  State<drawerexport> createState() => _drawerexportState();
}

class _drawerexportState extends State<drawerexport> {
  final ZoomDrawerController zo = ZoomDrawerController();
 
  final myTextstyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white);
  @override
  MenuItemmExport currentitem = MenuItemExport.daily;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      drawerShadowsBackgroundColor: Color.fromARGB(255, 5, 5, 5),
      menuScreenWidth: MediaQuery.of(context).size.width,
      style: DrawerStyle.defaultStyle,
      menuScreen: Builder(
        builder: (context) => MenuPageExport(
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
      case MenuItemExport.daily:
        return daily();
      case MenuItemExport.logistical:
        return logistical();
      case MenuItemExport.rewards:
        return rewards();
    }
    return BottomNavigation();
  }
}
