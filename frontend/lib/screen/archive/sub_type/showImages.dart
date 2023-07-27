import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontier/main.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import 'view.dart';

class showImages extends StatefulWidget {
  const showImages({super.key});

  @override
  State<showImages> createState() => _showImagesState();
}

class _showImagesState extends State<showImages> {
  Request _request = Request();
  bool _isImageEnlarged = false;
  String? _enlargedImageUrl;
  void initState() {
    getFilename();
    super.initState();
  }

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
          FutureBuilder(
            future: getFilename(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        List.generate(snapshot.data['data'].length, (index) {
                      return Container(
                        margin: EdgeInsets.only(top: 50),
                        width: 100,
                        // decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isImageEnlarged = true;
                                _enlargedImageUrl =
                                    '$imageurl/${snapshot.data['data'][index]['file_name']}';
                              });
                            },
                            child: Container(
                         margin: EdgeInsets.symmetric(horizontal: 8),
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                              
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '$imageurl/${snapshot.data['data'][index]['file_name']}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            )),
                      );
                    }),
                  ),
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
              return Text("Error");
            },
          ),
          if (_isImageEnlarged && _enlargedImageUrl != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  // _isImageEnlarged = false;
                  // _enlargedImageUrl = null;
                });
              },
                child: Container(
                // margin: EdgeInsets.symmetric(vertical: 100),
                height: size.height,
                width: size.width,
              
                child: Center(
                  child: Image.network(
                    _enlargedImageUrl!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
      ],
    ),
        ));
  }

  getFilename() async {
    print("========================>");
    print(Subtype.subtype_id.toString());
    var res = await _request.postRequest(
        getanamefile, {"contra_id": Subtype.subtype_id.toString()});
    if (res['status'] == "success") {
      return res;
    }
  }
}
