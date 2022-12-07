import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Unsigned_contracts extends StatefulWidget {
  const Unsigned_contracts({super.key});

  @override
  State<Unsigned_contracts> createState() => _Unsigned_contractsState();
}

class _Unsigned_contractsState extends State<Unsigned_contracts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: Container(
        child: Text("Unsigned_contracts"),
      ),
    );
  }
}
