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
import 'EditArchivePage.dart';
import 'ImageGalleryPage.dart';

import 'view.dart';

class details extends StatefulWidget {
  details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  late final List<String> imageLinks;
  bool Visible = false;
  Request _request = Request();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("File Details"),
        backgroundColor: Color.fromRGBO(66, 96, 137, 1),
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/6.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Row(
              children: [SizedBox(height: 30)],
            ),
            FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data['data'].isEmpty) {
                  return Center(child: Text("No data available."));
                }

                return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    var item = snapshot.data['data'][i];
                    return FutureBuilder<List<String>>(
                      future: getImages(item['id'].toString()),
                      builder: (context, imageSnapshot) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // File Name in a rectangle container with bold text
                                Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  child: ListTile(
                                    leading: Icon(Icons.insert_drive_file,
                                        color: Color(0XFF27394E)),
                                    title: Text(
                                      "File Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                        Text(item['name'] ?? 'Not available'),
                                  ),
                                ),

                                // Archived Date in a rectangle container with italic text
                                Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    leading: Icon(Icons.date_range,
                                        color: Colors.green),
                                    title: Text(
                                      "Archived Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                        item['date'] ?? 'Not available',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ),

                                // Description in a rectangle container with underline
                                Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    leading: Icon(Icons.description,
                                        color:
                                            Color.fromARGB(255, 122, 110, 1)),
                                    title: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      item['description'] ?? 'Not available',
                                    ),
                                  ),
                                ),

                                if (imageSnapshot.hasData &&
                                    imageSnapshot.data!.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(30, 0, 2, 2),
                                        child: Text(
                                          "Attachments:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        alignment: WrapAlignment.start,
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: imageSnapshot.data!
                                            .map((img) => GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            ImageGalleryPage(
                                                                imageUrl:
                                                                    "$imageurl/$img"),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        30, 2, 2, 2),
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            "$imageurl/$img"),
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          // Print action
                                        },
                                        icon: Icon(Icons.print),
                                        label: Text("Print"),
                                        style: ElevatedButton.styleFrom(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 6),
                                          textStyle: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          final item = snapshot.data['data'][i];
                                          final images = await getImages(
                                              item['id'].toString());

                                          Get.to(() => EditArchivePage(
                                                archivId: item['id'].toString(),
                                                initialName: item['name'],
                                                initialDate: item['date'],
                                                initialDescription:
                                                    item['description'],
                                                initialImages: images,
                                              ));
                                        },
                                        icon: Icon(Icons.edit),
                                        label: Text("Edit"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 6),
                                          textStyle: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          bool? confirm =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title:
                                                  Text("Delete Confirmation"),
                                              content: Text(
                                                  "Do you want to delete this file and all its images?"),
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
                                                .postRequest(deleteURL, {
                                              "archiv_id":
                                                  item['id'].toString(),
                                            });

                                            if (response['status'] ==
                                                "success") {
                                              Get.to(
                                                  Subtype()); // Navigate to Subtype view
                                            } else {
                                              Get.snackbar(
                                                  "Error", "Failed to delete");
                                            }
                                          }
                                        },
                                        icon: Icon(Icons.delete),
                                        label: Text("Delete"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 6),
                                          textStyle: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    print(Subtype.subtype_id.toString());
    var response = await _request
        .postRequest(getdetails, {"id": Subtype.subtype_id.toString()});
    if (response['status'] == "success") {
      return response;
    }
  }

  Future<List<String>> getImages(String contraId) async {
    var response = await _request.postRequest(getanamefile, {
      "contra_id": contraId,
    });
    if (response['status'] == "success") {
      return List<String>.from(
          response['data'].map((img) => img['file_name'].toString()));
    } else {
      return [];
    }
  }
}
