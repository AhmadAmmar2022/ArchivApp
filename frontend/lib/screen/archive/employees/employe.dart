import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class employe extends StatefulWidget {
  const employe({super.key});

  @override
  State<employe> createState() => _employeState();
}

class _employeState extends State<employe> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("الموظفين"),
          backgroundColor: Color.fromRGBO(126, 95, 2, 1),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
             ZoomDrawer.of(context)!.toggle();// 
            },
          ),
      
        ),
        body: Container(
          
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "images/6.png",
                ),
                fit: BoxFit.fill,
              ),
            )));
  }
}