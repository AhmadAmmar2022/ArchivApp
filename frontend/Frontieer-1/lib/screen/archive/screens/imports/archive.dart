import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class importHome extends StatefulWidget {
  const importHome({super.key});

  @override
  State<importHome> createState() => _importHomeState();
}

class _importHomeState extends State<importHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          title: Text("arachive"),
          backgroundColor: Color.fromRGBO(126, 95, 2, 1),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          )),
      body:Container(child:Text("hi im achive")),
    );
  }
}