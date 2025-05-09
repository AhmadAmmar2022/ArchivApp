import 'dart:ui';

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

import '../../../../../widget/customcardchild.dart';
import '../type/viewtype.dart';
import 'add.dart';
import 'details.dart';

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
  String searchQuery = '';

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View file"),
          backgroundColor: Color.fromRGBO(66, 96, 137, 1),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => Add());
            },
            backgroundColor: Color.fromARGB(255, 1, 54, 97),
            child: Icon(
              Icons.add,
              color: Color.fromARGB(255, 255, 255, 255),
            )),
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
                SizedBox(
                  height: 20,
                ),
                CustomTextFild(
                  fillColor: Color.fromARGB(255, 247, 248, 250),
                  icon: Icon(Icons.search),
                  hint: "Search",
                  controller: search,
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
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
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 3 / 2,
                          ),
                          padding: EdgeInsets.all(16),
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (BuildContext context, int i) {
                            final item = snapshot.data['data'][i];
                            return GestureDetector(
                              onTap: () {
                                Subtype.subtype_id = item['id'];
                                Get.to(details());
                              },
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                color: Colors.white,
                                shadowColor: Colors.black.withOpacity(0.1),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1),
                                      Text(
                                        item['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff27394E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
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
    var url = "$getsubtype?type_id=${Viewtype.type_id}";
    if (searchQuery.isNotEmpty) {
      url += "&search=$searchQuery";
    }
    var response = await _request.getRequest(url);
    if (response['status'] == "success") {
      return response;
    }
  }

  delete(String i) async {
    var response =
        await _request.postRequest(deleteURL, {"contra_id": i.toString()});
    if (response['status'] == "success") {
      print(response);
      return response; //
    }
  }
}
