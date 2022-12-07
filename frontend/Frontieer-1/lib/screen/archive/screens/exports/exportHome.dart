import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ExportHome extends StatefulWidget {
  const ExportHome({super.key});

  @override
  State<ExportHome> createState() => _ExportHomeState();
}

class _ExportHomeState extends State<ExportHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("salary"),
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
