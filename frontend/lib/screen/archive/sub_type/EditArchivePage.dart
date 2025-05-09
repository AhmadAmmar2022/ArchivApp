import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../const/linkes.dart';
import '../../../functions/globalfunctions.dart';
import '../../../functions/httpfunctions/Request.dart';
import '../../../main.dart';
import '../../../widget/CustomTextfild.dart';
import 'view.dart';

class EditArchivePage extends StatefulWidget {
  final String archivId;
  final String initialName;
  final String initialDate;
  final String initialDescription;
  final List<String> initialImages;

  EditArchivePage({
    required this.archivId,
    required this.initialName,
    required this.initialDate,
    required this.initialDescription,
    required this.initialImages,
  });

  @override
  State<EditArchivePage> createState() => _EditArchivePageState();
}

class _EditArchivePageState extends State<EditArchivePage> {
  late TextEditingController nameCtl;
  late TextEditingController dateCtl;
  late TextEditingController descCtl;

  Request _request = Request();

  late List<String> currentImages;
  List<String> imagesToDelete = [];
  List<File> newImages = [];

  @override
  void initState() {
    super.initState();
    nameCtl = TextEditingController(text: widget.initialName);
    dateCtl = TextEditingController(text: widget.initialDate);
    descCtl = TextEditingController(text: widget.initialDescription);
    currentImages = List.from(widget.initialImages);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit File"),
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
          padding: EdgeInsets.all(16),
          children: [
            CustomTextFild(
              fillColor: Color(0xffADC0D4),
              controller: nameCtl,
              hint: "File Name",
              icon: Icon(Icons.person),
              onChanged: (v) => validate(v!, 2, 25),
            ),
            CustomTextFild(
              fillColor: Color(0xffADC0D4),
              controller: dateCtl,
              hint: "Archived Date",
              icon: Icon(Icons.date_range),
              onChanged: (v) => validate(v!, 2, 10),
            ),
            CustomTextFild(
              fillColor: Color(0xffADC0D4),
              controller: descCtl,
              hint: "Description",
              icon: Icon(Icons.description),
              onChanged: (v) => validate(v!, 2, 100),
            ),
            SizedBox(height: 20),
            Text("Current Images:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: currentImages.map((img) {
                return Stack(
                  children: [
                    Image.network("$imageurl/$img",
                        width: 100, height: 100, fit: BoxFit.cover),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentImages.remove(img);
                            imagesToDelete.add(
                                Uri.parse("$imageurl/$img").pathSegments.last);
                          });
                        },
                        child: Container(
                          color: Colors.black54,
                          child:
                              Icon(Icons.close, size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Add New Images:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            OutlinedButton.icon(
              icon: Icon(Icons.add_a_photo),
              label: Text("Select Images"),
              onPressed: _pickNewImages,
            ),
            if (newImages.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: newImages.map((file) {
                  return Stack(
                    children: [
                      Image.file(file,
                          width: 100, height: 100, fit: BoxFit.cover),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => newImages.remove(file));
                          },
                          child: Container(
                            color: Colors.black54,
                            child: Icon(Icons.close,
                                size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text("Save Changes"),
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickNewImages() async {
    final List<XFile>? picks = await ImagePicker().pickMultiImage();
    if (picks != null) {
      setState(() {
        newImages.addAll(picks.map((x) => File(x.path)));
      });
    }
  }

  Future<void> _saveChanges() async {
    final body = {
      "archiv_id": widget.archivId,
      "name": nameCtl.text,
      "date": dateCtl.text,
      "description": descCtl.text,
      "deleted_files": jsonEncode(imagesToDelete),
    };

    final resp = await _request.postFile(editSubType, body, newImages,
        fileField: "new_files");

    if (resp != null && resp['status'] == "success") {
      Get.to(Subtype());
      Get.snackbar("Saved", "Archive updated successfully");
    } else {
      Get.snackbar("Error", "Failed to save changes");
    }
  }
}
