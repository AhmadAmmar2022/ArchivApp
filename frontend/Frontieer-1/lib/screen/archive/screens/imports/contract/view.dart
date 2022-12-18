import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/archive/screens/imports/contract/details.dart';
import 'package:frontier/screen/archive/screens/imports/contract/edite.dart';
import 'package:get/get.dart';

import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/customcard.dart';
import '../../../../BottomNavigationBar.dart';
import 'add.dart';

class ViewArchive extends StatelessWidget {
  ViewArchive({super.key});

  Request _request = Request();

  static late String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Add());
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ),
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
            child: ListView(
          children: [
            FutureBuilder(
                future: getdata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return customCard(
                              row: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        var response = await _request
                                            .postRequest(deleteURL, {
                                          "contra_id": snapshot.data['data'][i]
                                                  ['contra_id']
                                              .toString()
                                        });
                                        if (response['status'] == "success") {
                                          // Get.to(() => BottomNavigation());
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        await Get.to(() => Edit(
                                            contract: snapshot.data['data'][i]));
                                      },
                                    )
                                  ]),
                              onTap: () {
                                id = snapshot.data['data'][i]['contra_id']
                                    .toString();
                                Get.to(() => details());
                              },
                              name:
                                  "${snapshot.data['data'][i]['contra_name']}",
                              date:
                                  "${snapshot.data['data'][i]['contra_date']}");
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

                  return Text("  لا يوجد اي عقود ");
                })
          ],
        )));
  }

  getdata() async {
    var response = await _request.postRequest(getarchive, {
      "user_id": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      return response;
    }
  }

  delete(String i) async {
    var response =
        await _request.postRequest(deleteURL, {"contra_id": i.toString()});
    print(id);
    if (response['status'] == "success") {
      print(response);
      return response;
    }
  }
}
