import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';
import 'package:frontier/screen/archive/screens/imports/sub_type/details.dart';
import 'package:frontier/screen/archive/screens/imports/sub_type/edite.dart';
import 'package:frontier/screen/archive/screens/imports/type/viewtype.dart';
import 'package:get/get.dart';

import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customcard.dart';

import '../../../../../widget/customcardchild.dart';
import 'FilesPage.dart';
import 'add.dart';

class Subtype extends StatefulWidget {
  static late String subtype_id;
  Subtype({
    super.key,
  });

  @override
  State<Subtype> createState() => _SubtypeState();
}

class _SubtypeState extends State<Subtype> {
  Request _request = Request();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Add());
          },
          backgroundColor: Color(0xff27394E),
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
                Row(children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      ZoomDrawer.of(context)!.toggle();
                    },
                    color: Colors.white,
                  ),
                
                  const SizedBox(
                    width: 280,
                  ),
                  Image.asset("images/5.png")
                ]),
                  CustomTextFild(
                  fillColor: Color.fromARGB(255, 247, 248, 250),
                  icon: Icon(Icons.search),
                  hint: "Search",
                  controller: search,
                  valu: (val) {},
                ),   
                FutureBuilder(
                    future: getdata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                child: CustomCardChild(
                                  // onPreesEdit: () async {
                                  //   await Get.to(() =>
                                  //       Edit(contract: snapshot.data['data'][i]));
                                  // },
                                  // onPreesDelete: () async {
                                  //   var response = await _request.postRequest(
                                  //       deleteURL, {
                                  //     "contra_id": snapshot.data['data'][i]
                                  //             ['contra_id']
                                  //         .toString(),
                                  //             "image_name": snapshot.data['data'][i]
                                  //             ['contra_image']
                                  //         .toString()
                                  //   });
                                  //   if (response['status'] =="success") {
                                  //        setState(() {
                              
                                  //        });
                                  //   }
                                  // },
                              
                                  name:
                                  "${snapshot.data['data'][i]['contra_name']}",
                                
                                ),
                                onTap: () {
                                  Subtype.subtype_id=snapshot.data['data'][i]['contra_id'];
                                  Get.to(details());
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
                      return Text("");
                    })
              ],
            )));
  }

  getdata() async {
    print(Viewtype.type_id);
    var response =
        await _request.postRequest(getsubtype, {"type_id": Viewtype.type_id});
    if (response['status'] == "success") {
      return response;
    }
  }

  delete(String i) async {
    var response =
        await _request.postRequest(deleteURL, {"contra_id": i.toString()});

    if (response['status'] == "success") {
      print(response);
      return response;
    }
  }
}
