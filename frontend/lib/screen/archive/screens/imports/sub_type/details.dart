import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/Auth/login.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/main.dart';
import 'package:get/get.dart';

import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/customcard.dart';
import 'view.dart';

class details extends StatelessWidget {
  details({super.key});

  Request _request = Request();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.navigate_next_outlined))
            ],
            title: Text("details"),
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
                                DataTable(
                                  checkboxHorizontalMargin: 4,
                                  border: TableBorder.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1),
                                  columns: [
                                    DataColumn(
                                        label: Text('اسم الجهة ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('التاريخ ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    DataColumn(
                                        label: Text('المبلغ ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text(
                                          '${snapshot.data['data'][i]['contra_name']}')),
                                      DataCell(Text(
                                          '${snapshot.data['data'][i]['contra_date']}')),
                                      DataCell(Text(
                                          '${snapshot.data['data'][i]['contra_salary']}')),
                                    ]),
                                  ],
                                ),SizedBox(height: 20,),
                                
                                Container(
                                  width: 400,
                                  height: 600,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image:  DecorationImage(
                                      image: NetworkImage(
                                                 '$imageurl/${snapshot.data['data'][i]['contra_image']}'),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      width: 8,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                )
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
                })
          ],
        )));
  }

  getData() async {
    var response = await _request
        .postRequest(getdetails, {"contra_id": Subtype.subtype_id.toString()});
    if (response['status'] == "success") {
      print("---------------------------->");
      print(Subtype.subtype_id);
      return response;
    }
  }
}
