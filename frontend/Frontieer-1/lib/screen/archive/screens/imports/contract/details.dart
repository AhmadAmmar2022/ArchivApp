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
import '../view.dart';



class details extends StatelessWidget {
  details({super.key});

  Request _request = Request();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return  customCard(
                            onTap: (){
                            },
                             name: "${snapshot.data['data'][i]['contra_name']}", 
                             date: "${snapshot.data['data'][i]['contra_date']}")
                              ;
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
    var response = await _request.postRequest(getdetails, {
      "contra_id": ViewArchive.id
    });
    if (response['status'] == "success") {
      return response;
     
    }
  }
}
