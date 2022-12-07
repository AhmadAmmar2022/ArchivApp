import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Contracts extends StatefulWidget {
  const Contracts({super.key});

  @override
  State<Contracts> createState() => _ContractsState();
}

class _ContractsState extends State<Contracts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
         leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
      ),
       body: Container(child: Text("contracts"),),
    );
  }
}