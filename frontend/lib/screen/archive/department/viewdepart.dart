import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';

import 'package:get/get.dart';

import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customcard.dart';

import '../employees/viewemploye.dart';
import '../sub_type/view.dart';
import 'add.dart';
import 'editdepart.dart';

class Viewdepart extends StatefulWidget {
  static late String depart_id;
  Viewdepart({
    super.key,
  });

  @override
  State<Viewdepart> createState() => _ViewdepartState(); // add final rodi
}

class _ViewdepartState extends State<Viewdepart> {
  Request _request = Request();

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("الصفحة الاساسية "),
          backgroundColor: Color.fromRGBO(66, 96, 137, 1),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle(); //
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddDepartment());
          },
          backgroundColor: Color(0xFf27394E),
          child: const Icon(Icons.add),
        ),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "images/6.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: [
              Container(
                // margin: EdgeInsets.all(10),
                // height: size.height / 2.4,
                // width: size.width / 3,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(50),
                //   color: Color(0XFFAAAEB2),
                //   border: Border.all(
                //       color: Color.fromARGB(255, 255, 255, 255), width: 0),
                // ),
                child: FutureBuilder(
                    future: getdata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                child: Card(
                                  child: ListTile(
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              await Get.to(() => Editdepart(
                                                  contract: snapshot
                                                      .data['data'][i]));
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              {}
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                    title: Text(
                                        "${i + 1}-  ${snapshot.data['data'][i]['depart_name']}"),
                                  ),
                                ),
                                onTap: () {
                                  Viewdepart.depart_id = snapshot.data['data'][i]['depart_id'].toString();
                                 
                                 
                                  Get.to(() => ViewEmp());
                                },
                              );
                            });
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }

                      return Center(
                        child: Text(" لا يوجد اقسام  "),
                      );
                    }),
              )
            ],
          ),
        ));
  }

 Future getdata() async {
    var response = await _request.getRequest(getdepartUrl);
    if (response['status'] == "success") {
      return response; //
    }
  }
}
