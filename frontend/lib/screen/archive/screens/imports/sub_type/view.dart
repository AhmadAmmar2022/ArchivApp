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
import '../../../../../widget/customcard.dart';

import 'add.dart';

class Subtype extends StatefulWidget {
   static late String subtype_id;
  Subtype({super.key, });



  @override
  State<Subtype> createState() => _SubtypeState();
}

class _SubtypeState extends State<Subtype> {
  Request _request = Request();

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
            title: Text(" الاصناف الفرعية "),
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
                    return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (BuildContext context, int i) {
                          return customCard(
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
                            valueColor:
                                  snapshot.data['data'][i]['contra_date'],
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
    var response = await _request.postRequest(getsubtype, {
      "type_id":Viewtype.type_id
    });
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



