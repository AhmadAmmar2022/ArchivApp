import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:frontier/main.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

import '../../../../../const/linkes.dart';
import '../../../../../functions/globalfunctions.dart';
import '../../../../../functions/httpfunctions/Request.dart';
import '../../../../../widget/CustomText.dart';
import '../../../../../widget/CustomTextfild.dart';
import '../../../../../widget/customButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../type/addtype.dart';
import '../type/viewtype.dart';
import 'FilesPage.dart';
import 'view.dart';

class Add extends StatefulWidget {
  Add({super.key});
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController salary = TextEditingController();
  // File? myfile;

  Request _request = Request();
  //List<PlatformFile>? _files;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  bool issigned = false;
  FilePickerResult? files;
    List<File> Allfiles=[];
 
  var fileTemporary;
  FilePickerResult? result;// 
  List<PlatformFile> _images = [];
  bool isloading = false;
  get getAppl => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/7.jpg",
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromARGB(255, 250, 251, 253),
              border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), width: 0),
            ),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    CustomTextFild(
                      fillColor: Color(0xffADC0D4),
                      icon: Icon(Icons.person),
                      hint: "اسم الجهة",
                      controller: name,
                      valu: (val) {
                        return validate(val!, 25, 2);
                      },
                    ),
                    CustomTextFild(
                      fillColor: Color(0xffADC0D4),
                      icon: Icon(Icons.password),
                      hint: "تاريخ توقيع العقد ",
                      controller: date,
                      valu: (val) {
                        return validate(val!, 10, 2);
                      },
                    ),
                    CustomTextFild(
                      fillColor: Color(0xffADC0D4),
                      icon: Icon(Icons.email),
                      hint: "المبلغ",
                      controller: salary,
                      valu: (val) {
                        return validate(val!, 15, 2);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 320,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 14, 0, 0), width: 1),
                        color: Color.fromARGB(255, 252, 252, 253),
                      ),
                      child: files != null
                          ? GridView.builder(
                              padding: EdgeInsets.all(2),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 2,
                              ),
                              itemCount: files!.files.length,
                              itemBuilder: (context, index) {
                                final file = files!.files[index];
                                return buildFile(file);
                              },
                            )
                          : Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.cloud_upload),
                                  onPressed: () => _selectFiles(),
                                  iconSize: 30,
                                ),
                                Text("اضغط هنا لاختيار ملف ")
                              ],
                            )),

                      //
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Container(
                    //   child: InkWell(
                    //     child: Text(
                     //       " اضغط هنا لاختيار ملف ",
                    //       style: TextStyle(
                    //           color: Color.fromARGB(255, 10, 148, 240)),
                    //     ),
                    //     onTap: () => _showBottomSheet(),
                    //   ),
                    // ),
                    CustomButton(
                      text: " اضافة ",
                      onPress: () async {
                        await _add();
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }

  Future<FilePickerResult?> _selectFiles() async {
     try {
       files = await FilePicker.platform.pickFiles(
       allowMultiple: true,
       );
      if (files != null) {
         for (PlatformFile file in files!.files) {
          Allfiles.add(File(file.path!));
              }
        setState(() {});// 
        // paths = result!.paths.map((path) => path!,).toList();

      }
      } catch (e) {
       print("Error picking files=============>: $e");
      }
       return files;
    
     }

  // _pickedFile() async {
  //    Allfiles= (await _selectFiles()) as List<PlatformFile> ;
  //   setState(() {
      
  //   });
  // }

  Future<void> _add() async {
    // paths.forEach((element) {
    //   print(element);
    // });
    if (formstate.currentState!.validate()) {
      var response = await _request.postFile(
          AddSubTypeUrl,
          {
            "contra_name": name.text,
            "contra_date": date.text,
            "contra_issigned": "1",
            "contra_salary": salary.text,
            "doc_id": Viewtype.type_id.toString()
          },
          Allfiles);
      print("==========================");// 
      print(response);
      if (response['status'] == "success") 
      {
        Get.snackbar(
          "${name.text}",
          "completed successfully",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        Get.to(() => Subtype());
      } else {
        AlertDialog(
          title: Text("zzzzzzzz"),
        );
      }
    }
  }

  // Future uploadImageFromCamira() async {
  //   try {
  //     _files = (await FilePicker.platform.pickFiles(
  //             type: FileType.any,
  //             allowMultiple: true,
  //             allowedExtensions: null))!
  //         .files;

  //     if (_files == null) return;
  //     if (_files != null) {
  //       for (var file in _files ?? []) {
  //         var imagesTemporary = File(file.path);
  //         imageFileList!.add(imagesTemporary);
  //       }
  //     }
  //   } catch (e) {}
  //   print('========================>');
  //   imageFileList!.forEach((element) {
  //     print(element);
  //   });
  // }

  // Future uploadImageFromGallary() async {
  //   try {
  //     XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     setState(() {
  //       myfile = File(xfile!.path);
  //     });
  //   } on PlatformException catch (e) {
  //     print("================================>");
  //     print(e);
  //   }
  // }

  Widget switcheadaptive() {
    return Switch(
      value: issigned,
      onChanged: (value) {
        setState(() {
          issigned = value;
        });
      },
    );
  }
// Future<List<PlatformFile>> pickFiles() async {
//   List<PlatformFile> files =
//       (await FilePicker.platform.pickFiles(allowMultiple: true)) as List<PlatformFile>;
//   return files;
// }

  // showBottomSheet() async {
  //       print("===================================================>");
  //   result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //    try{
  //     if (result == null) return;
  //     for (var i=0 ;i<result.files.length;i++)
  //        {
  //             print("===================================================>");
  //                fileTemporary=File(result.files[i]);
  //               print("===================================================>");

  //               fileList.add(fileTemporary);

  //         }}
  //         catch(e){
  //           print(e);
  //         }

  //   // final file = result.files.first;
  //   // print("========================>");
  //   // print("the path :${file.name}");
  //   // final newFile = await saveFile(file);
  //   // print(file.path);
  //   // print(newFile.path);
  //   //   openFiles(result.files);

  //   // showModalBottomSheet<void>(
  //   //     backgroundColor: Color(0xFF5C81AC),
  //   //     context: context,
  //   //     builder: (BuildContext context) {
  //   //       return Container(
  //   //         child: Column(
  //   //           mainAxisSize: MainAxisSize.min,
  //   //           children: <Widget>[
  //   //             Text(
  //   //               " اختيار صورة من",
  //   //               style: TextStyle(
  //   //                   color: Color.fromARGB(255, 247, 248, 249), fontSize: 20),
  //   //             ),
  //   //             Container(
  //   //               child: ListTile(
  //   //                 title: Text("المعرض"),
  //   //                 leading: Icon(Icons.image),
  //   //                 onTap: () async {
  //   //                   Navigator.of(context).pop();
  //   //                   await uploadImageFromGallary();
  //   //                 },
  //   //               ),
  //   //             ),
  //   //             Container(
  //   //               child: ListTile(
  //   //                 title: Text("الكميرا"),
  //   //                 leading: Icon(Icons.camera),
  //   //                 onTap: () async {
  //   //                   Navigator.of(context).pop();
  //   //                   await

  //   // ();
  //   //                 },
  //   //               ),
  //   //             )
  //   //           ],
  //   //         ),
  //   //       );
  //   //     });
  //   setState(() {
  //     // pickFiles = result.first;
  //   });
  // }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  Future<File> saveFile(PlatformFile file) async {
    final appstorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appstorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  openFiles(List<PlatformFile> files) {
    return files;
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} kb';
    final extension = file.extension ?? 'none'; // Ahmad Ammar Almohmmad so

    // final color =getColor(extension);
    return InkWell(
      onTap: () {
        openFile(file);
      },
      child: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 72, 71, 71),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$extension',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 9, 0, 0)),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              file.name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  color: Color.fromARGB(255, 2, 0, 0)),
            ),
            Text(
              fileSize,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  color: Color.fromARGB(255, 3, 0, 0)),
            )
          ],
        ),
      ),
    );
  }
}
