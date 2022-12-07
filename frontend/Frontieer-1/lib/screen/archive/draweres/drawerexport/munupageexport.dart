
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontier/screen/archive/draweres/drawerexport/Menutemexport.dart';
import 'package:frontier/screen/archive/screens/exports/daily.dart';
import 'package:frontier/screen/archive/screens/exports/rewards.dart';

class MenuPageExport extends StatelessWidget {
  final MenuItemmExport currentitem;
  final ValueChanged<MenuItemmExport> onSelectedItem;

  const MenuPageExport(
      {super.key, required this.currentitem, required this.onSelectedItem});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              ...MenuItemExport.all.map(BuildMenu).toList()
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildMenu(MenuItemmExport item) => ListTileTheme(
        selectedColor: Colors.amber,
        child: ListTile(
            selectedTileColor: Colors.black26,
            selected: currentitem == item,
            minLeadingWidth: 20,
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () {
              onSelectedItem(item);
            }),
      );
}

class MenuItemExport {
 
  static const daily = MenuItemmExport("daily", Icons.home_outlined);
  static const logistical = MenuItemmExport("logistical", Icons.archive_rounded);
  static const rewards = MenuItemmExport("rewards", Icons.archive_outlined);
       static const all = <MenuItemmExport>[daily,logistical , rewards,];
  
}


