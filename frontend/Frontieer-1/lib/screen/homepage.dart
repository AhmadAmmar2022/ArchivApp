import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/main.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: (() {
            sharedpref.clear();
          Get.to(Login());
          }), icon: Icon(Icons.exit_to_app))
        ],),
      body: Container(child: Text("homepage"),)
    );
  }
}