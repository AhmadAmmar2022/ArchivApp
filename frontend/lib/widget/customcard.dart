import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../screen/archive/screens/imports/type/edit.dart';

class customCard extends StatelessWidget {
  var size, height, width;

  final String name;
  final int valueColor;
  final void Function()? onPreesEdit;
  final void Function()? onPreesDelete;

  customCard({
    Key? key,
    required this.name,
    required this.valueColor,
    required this.onPreesEdit,
    this.onPreesDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets. fromLTRB(2, 2, 5, 4),
         //padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0XFFAAAEB2),
          border:
              Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 0),
        ),
        child: Column(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.folder),
                onPressed: () {},
                iconSize: 75,
                color: Color(valueColor),
              ),
            ),
            Container(
              child: Text(
                "$name",
                style: const TextStyle(
                 fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
     
            ),        
             SizedBox(height:10 ,),
             Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    
                  },
                ),
                SizedBox(
                  width: 80,
                ),
                IconButton(icon: Icon(Icons.edit),
                 onPressed:onPreesEdit),
              ],
            )
          ],
        ));
  }
}
// ListTile(title:Text("$name",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),subtitle:Text("$date") ,trailing:row)
