import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontier/const/linkes.dart';
import 'package:frontier/screen/archive/department/viewdepart.dart';

import '../../../functions/httpfunctions/Request.dart';
import '../../../main.dart';
import '../../../widget/CustomTextfild.dart';
import '../../../widget/customcardchild.dart';

class ViewEmp extends StatefulWidget {
  const ViewEmp({super.key});

  @override
  State<ViewEmp> createState() => _ViewEmpState();
}

class _ViewEmpState extends State<ViewEmp> {
  Request _request = Request();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.to(() => Add());
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
                      // ZoomDrawer.of(context)!.toggle();
                    },
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 280,
                  ),
                  Image.asset("images/5.png")
                ]),
              
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
                                    childAspectRatio: 1 / 1.3),
                            itemCount: snapshot.data['data'].length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                margin: EdgeInsets.all(10.0),
                                padding:EdgeInsets.all(10.0) ,
                           
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                  image: NetworkImage(
                                    '$imageurl/6229image_picker2864742277261927814.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                  color: Color.fromARGB(255, 57, 57, 58),
                                  borderRadius: BorderRadius.circular(40),
                                  border:Border.all(color: Colors.black, width: 2),
                                ),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                //  Image.network("$imageurl/1520image_picker8547022908400600576.jpg",fit: BoxFit.cover,height: 125,)
                                  // image: NetworkImage(
                                  //   '$imageurl/${snapshot.data['data'][index]['file_name']}',
                                  // ),
                                  // fit: BoxFit.cover,
                                
                                   
                               // Replace with your image URL
                                    
                              SizedBox(height: 180,),
                                    Expanded(
                                      child: Text(
                                        'Ahmad ammar',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                             color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                         Expanded(
                                      child: Text(
                                        'software engineer',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

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
                      return Text("");
                    })
              ],
            )));
  }

  Future getdata() async {
    print("=====************");
    print(Viewdepart.depart_id);
    print("=====************");

    var response = await _request
        .postRequest(getemployee, {"depart_id": Viewdepart.depart_id});
    if (response['status'] == "success") {
      return response;
    }
  }
}
