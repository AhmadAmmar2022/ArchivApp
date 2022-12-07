import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class logistical extends StatefulWidget {
  const logistical({super.key});

  @override
  State<logistical> createState() => _logisticalState();
}

class _logisticalState extends State<logistical> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
          title: Text("logistical"),
          backgroundColor: Color.fromRGBO(126, 95, 2, 1),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          )),
    );
  }
}