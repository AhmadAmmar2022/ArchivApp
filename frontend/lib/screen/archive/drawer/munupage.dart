import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

import 'Menutem.dart';

class MenuPage extends StatelessWidget {
  final MenuItemm currentitem;
  final ValueChanged<MenuItemm> onSelectedItem;

  const MenuPage(
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
              ...MenuItems.all.map(BuildMenu).toList()
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildMenu(MenuItemm item) => ListTileTheme(
        selectedColor: Color.fromARGB(255, 4, 98, 251),
        child: ListTile(
            selectedTileColor: Color.fromARGB(66, 12, 0, 0),
            selected: currentitem == item,
            minLeadingWidth: 20,
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () {
              onSelectedItem(item);
            }),
      );
}

class MenuItems {
  static const hompage = MenuItemm("Home Page ", Icons.home_outlined);
  static const Appointment = MenuItemm("Appointments", Icons.calendar_today);

  static const Finance = MenuItemm("Monthly Expenses", Icons.money);

  static const all = <MenuItemm>[hompage, Finance, Appointment];
}
