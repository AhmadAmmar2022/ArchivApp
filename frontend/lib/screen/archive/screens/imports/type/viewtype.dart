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
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customcard.dart';

import '../sub_type/view.dart';
import 'addtype.dart';
import 'edit.dart';

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
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Addtype());
          },
          backgroundColor: Color(0xFf27394E),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 35, 52, 70),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
          actions: [Image.asset("images/5.png")],
        ),
        body: Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "images/3.jpg",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView(
              children: [
                SizedBox(height: size.height / 2.9),
                CustomTextFild(
                  fillColor: Color(0xff838C96),
                  icon: Icon(Icons.search),
                  hint: "Search",
                  controller: search,
                  valu: (val) {},
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: size.height / 2.4,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0XFFAAAEB2),
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255), width: 0),
                  ),
                  child: FutureBuilder(
                      future: getdata(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                         
                          return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (BuildContext context, int i) {
                               
                                return customCard(
                                    onPreesEdit: () async {
                                      await Get.to(() => EditType(
                                          contract: snapshot.data['data'][i]));
                                    },
                                    onPreesDelete: () async {
                                      var response = await _request
                                          .postRequest(deletetypeURL, {
                                        "type_id": snapshot.data['data'][i]
                                                ['type_id']
                                            .toString(),
                                        "image_name": snapshot.data['data'][i]
                                                ['type_img']
                                            .toString()
                                      });
                                      if (response['status'] == "success") {
                                        setState(() {});
                                      }
                                    },
                                    onTap: () {
                                      Viewtype.type_id = snapshot.data['data']
                                              [i]['type_id']
                                          .toString();

                                      Get.to(() => Subtype(
                                          // type_id: Viewtype.type_id
                                          ));
                                    },
                                    name:
                                        "${snapshot.data['data'][i]['type_name']}",
                                    color:
                                        "${snapshot.data['data'][i]['type_color']}" );
                              });
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          child: Text(" لا يوجد عقود "),
                        );
                      }),
                )
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
