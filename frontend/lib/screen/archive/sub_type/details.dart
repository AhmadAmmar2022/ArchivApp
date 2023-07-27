import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';
import 'package:get/get.dart';

import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/customButton.dart';
import '../../../../../widget/customcard.dart';
import '../type/edit.dart';
import 'edite.dart';
import 'showImages.dart';
import 'view.dart';

class details extends StatefulWidget {
  details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  late final List<String> imageLinks;
  bool Visible=false;
  @override


  Request _request = Request();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
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
                FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Expanded(
                                          child: Container(
                                        height: 40,
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              width: 1,
                                              color: Color(0XFF13263D),
                                            )),
                                        child: Center(
                                            child: Text(
                                                "${snapshot.data['data'][i]['contra_date']}",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 28, 26, 89)))),
                                      )),
                                      Expanded(
                                          child: Container(
                                        height: 40,
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0XFF13263D),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                                "${snapshot.data['data'][i]['contra_salary']}",
                                                style: TextStyle(
                                                  color: Color(0XFF13263D),
                                                ))),
                                      )),
                                      Expanded(
                                          child: Container(
                                        height: 40,
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              width: 1,
                                              color: Color(0XFF13263D),
                                            )),
                                        child: Center(
                                            child: Text(
                                                "${snapshot.data['data'][i]['contra_name']}",
                                                style: TextStyle(
                                                  color: Color(0XFF13263D),
                                                ))),
                                      ))
                                    ]),
                                    SizedBox(
                                      height: 20,
                                    ),

                                    Container(
                                      width: size.width / 1.2,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          CustomButton(
                                            text: " طباعة ",
                                            onPress: () async {
                                              // await Add();
                                            },
                                          ),
                                          CustomButton(
                                            text: " حذف ",
                                            onPress: () async {
                                              var response = await _request
                                                  .postRequest(deleteURL, {
                                                "contra_id": snapshot
                                                    .data['data'][i]
                                                        ['contra_id']
                                                    .toString(),
                                                "image_name": snapshot
                                                    .data['data'][i]
                                                        ['contra_image']
                                                    .toString()
                                              });
                                              if (response['status'] ==
                                                  "success") {
                                                Get.to(() => Subtype());
                                                // Get.snackbar(
                                                //   "success",
                                                //   "  completed successfully",
                                                //   icon: Icon(Icons.person,
                                                //       color: Colors.white),
                                                //   snackPosition:
                                                //       SnackPosition.BOTTOM,
                                                //   backgroundColor:
                                                //       Colors.orange,
                                                //   borderRadius: 20,
                                                //   margin: EdgeInsets.all(15),
                                                //   colorText: Colors.white,
                                                //   duration:
                                                //       Duration(seconds: 4),
                                                //   isDismissible: true,
                                                //   forwardAnimationCurve:
                                                //       Curves.easeOutBack,
                                                // );
                                              }
                                            },
                                          ),
                                          CustomButton(
                                            text: " تعديل ",
                                            onPress: () async {
                                              await Get.to(() => Edit(
                                                  contract: snapshot
                                                      .data['data'][i]));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    //       ListView.builder(
                                    //    itemCount: imageLinks.length,
                                    //   itemBuilder: (context, index) {

                                    //  return Image.network('$imageurl/${imageLinks[index]}');
                                    //       },
                                    //       )
                                  ],
                                ),
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

                      return Text("Eroor");
                    }),OutlinedButton(onPressed: (){
                    setState(() {
                      Get.to(()=>showImages());
                    });
                    }, child: Text(" عرض المرفقات ")),
                      SizedBox(height: 300,),
              
              ],
            )));
  }

  getData() async {
    print(Subtype.subtype_id.toString());
    var response = await _request
        .postRequest(getdetails, {"contra_id": Subtype.subtype_id.toString()});
    if (response['status'] == "success") {
      print("---------------------------->");
      print(Subtype.subtype_id);
      return response;
    }
  }


}
