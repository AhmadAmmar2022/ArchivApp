import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontier/screen/archive/draweres/drawerexport/drawerexport.dart';

import 'archive/draweres/drawerimport/drawerimport.dart';
import 'archive/screens/imports/archive.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final screens = [ drawerexport(),drawerimport(),];
  int currentindex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() {
                currentindex = index;
              }),
          currentIndex: currentindex,
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 18,
          fixedColor: Color.fromARGB(255, 255, 255, 255),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: 'exports',
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.money),
                label: 'imports',
                backgroundColor: Theme.of(context).primaryColor),
          ]),
    );
  }
}
