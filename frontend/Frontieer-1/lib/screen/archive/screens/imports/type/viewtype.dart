import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/archive/screens/imports/sub_type/details.dart';
import 'package:frontier/screen/archive/screens/imports/sub_type/edite.dart';
import 'package:get/get.dart';

import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/customcard.dart';

import '../sub_type/view.dart';
import 'addtype.dart';

class Viewtype extends StatefulWidget {
  static late String type_id;
  Viewtype({
    super.key,
  });

  @override
  State<Viewtype> createState() => _ViewtypeState();
}

class _ViewtypeState extends State<Viewtype> {
  Request _request = Request();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Addtype());
          },
          backgroundColor: Color.fromARGB(255, 63, 39, 3),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
        ),
        body: Container(
            child: ListView(
          children: [
            FutureBuilder(
                future: getdata(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (BuildContext context, int i) {
                          return customCard(
                              onPreesEdit: () async {
                                await Get.to(() =>
                                    Edit(contract: snapshot.data['data'][i]));
                              },
                              onPreesDelete: () async {
                                var response =
                                    await _request.postRequest(deletetypeURL, {
                                  "type_id": snapshot.data['data'][i]['type_id']
                                      .toString(),
                                  "image_name": snapshot.data['data'][i]
                                          ['type_img']
                                      .toString()
                                });
                                if (response['status'] == "success") {
                                  setState(() {
                                   
                                  });
                                }
                              },
                              onTap: () {
                                Viewtype.type_id= snapshot.data['data'][i]
                                              ['type_id']
                                          .toString();
                                Get.to(() => Subtype(
                                      type_id: Viewtype.type_id
                                    ));
                              },
                              name: "${snapshot.data['data'][i]['type_name']}",
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

                  return Text("لا يوجد اي عقود");
                })
          ],
        )));
  }

  getdata() async {
    var response = await _request.getRequest(getTypeURL);
    if (response['status'] == "success") {
      return response;
    }
  }
}
