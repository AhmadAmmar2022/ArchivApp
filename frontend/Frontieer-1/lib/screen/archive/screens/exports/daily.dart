import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class daily extends StatefulWidget {
  const daily({super.key});

  @override
  State<daily> createState() => _dailyState();
}

class _dailyState extends State<daily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  AppBar(
          title: Text("daily"),
          backgroundColor: Color.fromRGBO(126, 95, 2, 1),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          )),
      body: Container());
  }
}