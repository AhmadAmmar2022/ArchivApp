import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';



import 'Menutem.dart';

class MenuPage extends StatelessWidget {
  final MenuItemmImport currentitem;
  final ValueChanged<MenuItemmImport> onSelectedItem;

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
              ...MenuItemImport.all.map(BuildMenu).toList()
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildMenu(MenuItemmImport item) => ListTileTheme(
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

class MenuItemImport {
 
  static const view = MenuItemmImport("homepage", Icons.home_outlined);
  static const Contracts = MenuItemmImport("Contracts", Icons.archive_rounded);
  static const Unsigned_contracts = MenuItemmImport("Unsignedcontracts", Icons.archive_outlined);
       static const all = <MenuItemmImport>[view,Contracts , Unsigned_contracts,];
  
}


