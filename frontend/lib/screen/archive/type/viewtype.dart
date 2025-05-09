import 'dart:ffi';
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

import '../sub_type/view.dart';
import 'addtype.dart';
import 'edit.dart';

class Viewtype extends StatefulWidget {
  static late String type_id;
  Viewtype({super.key});

  @override
  State<Viewtype> createState() => _ViewtypeState();
}

class _ViewtypeState extends State<Viewtype> {
  Request _request = Request();
  String searchQuery = "";
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size; // استلام حجم الشاشة
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Color.fromRGBO(66, 96, 137, 1),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle(); // القائمة الجانبية
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Addtype());
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Color(0xFF223546),
          )),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/3.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: size.height / 2.9),
            CustomTextFild(
              fillColor: Color.fromARGB(255, 247, 247, 247),
              icon: Icon(Icons.search),
              hint: "Search",
              controller: search,
              onChanged: (val) {
                setState(
                    () {}); // هذا سيعيد بناء الواجهة ويستدعي getdata من جديد
              },
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: size.height / 2.4,
              width: size.width / 3,
              child: FutureBuilder(
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
                        final item = snapshot.data['data'][i];
                        return InkWell(
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF607D8B).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Stack(
                                  children: [
                                    // زر الحذف
                                    Positioned(
                                      bottom: 2,
                                      left: 2,
                                      child: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.white),
                                        onPressed: () async {
                                          bool? confirm =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title:
                                                  Text("Delete Confirmation"),
                                              content: Text(
                                                  "Do you want to delete this folder along with all archives and images ?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: Text("Yes"),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirm == true) {
                                            var response = await _request
                                                .postRequest(deletetypeURL, {
                                              "type_id":
                                                  item['type_id'].toString(),
                                            });

                                            if (response['status'] ==
                                                "success") {
                                              Get.snackbar("ok",
                                                  "The folder has been successfully delete");
                                              setState(() {});
                                            } else {
                                              Get.snackbar(
                                                  "Error", "Deletion failed");
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    // زر التعديل
                                    Positioned(
                                      bottom: 2,
                                      right: 2,
                                      child: IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.white),
                                        onPressed: () {
                                          Get.to(EditType(contract: item));
                                        },
                                      ),
                                    ),
                                    // المحتوى الرئيسي
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Color(int.parse(
                                                  item['type_color'])),
                                              child: Icon(Icons.archive,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              item['type_name'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Viewtype.type_id =
                                snapshot.data['data'][i]['type_id'].toString();
                            Get.to(() => Subtype());
                          },
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error} حدث خطأ'),
                    );
                  }

                  return Center(
                    child: Text(" No data available "),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getdata() async {
    var userId = sharedpref.getString("id");
    var url = '$getTypeURL?user_id=$userId';

    // إذا المستخدم كتب في حقل البحث
    if (search.text.isNotEmpty) {
      url += '&search=${search.text}'; // أضف قيمة البحث إلى الرابط
    }

    var response = await _request.getRequest(url);
    if (response['status'] == "success") {
      return response;
    } else {
      print("Error: ${response['message']}");
    }
  }
}


// // Color(0xff838C96)
