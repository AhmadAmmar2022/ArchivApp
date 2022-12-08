import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';
import 'package:get/get.dart';

import '../../../../functions/httpfunctions/Request.dart';

class importHome extends StatefulWidget {
  const importHome({super.key});

  @override
  State<importHome> createState() => _importHomeState();
}

class _importHomeState extends State<importHome> {
  Request _request = Request();
  List data=[];
  @override
  void initState(){
     login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("arachive home"),
            backgroundColor: Color.fromRGBO(126, 95, 2, 1),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            )),
        body: Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: const Text(
                      "GFG",
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("List item $index"));
              }),
        ));
  }

  login() async {
    var response = await _request.postRequest(getarchive, {
      "user_id": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print(response);
       setState(() {
       data=response as List;
       print(data);
       });
    }
  }
}
