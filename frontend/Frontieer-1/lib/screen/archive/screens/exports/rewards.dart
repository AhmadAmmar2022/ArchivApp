import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class rewards extends StatefulWidget {
  const rewards({super.key});

  @override
  State<rewards> createState() => _rewardsState();
}

class _rewardsState extends State<rewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
          title: Text("rewards"),
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
