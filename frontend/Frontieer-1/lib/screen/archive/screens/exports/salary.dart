import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class salary extends StatefulWidget {
  const salary({super.key});

  @override
  State<salary> createState() => _salaryState();
}

class _salaryState extends State<salary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
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
