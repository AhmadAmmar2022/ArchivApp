import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomCardChild extends StatelessWidget {
  var size, height, width;
 
  final String name;

  // final void Function()? onPreesEdit;
  // final void Function()? onPreesDelete;
   
  CustomCardChild({
    Key? key,

    required this.name,

    // required this.onPreesEdit,
    // this.onPreesDelete, 
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.all(1),
        child: Column(
          children:  [
            Container(
              child: IconButton(
                icon: Icon(Icons.folder),
                onPressed: () {},
                iconSize: 70,
                color:Color(0xff13263D) ,
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
    
            // Row(
            //   children:
            //     [
            //         IconButton(
            //       icon: Icon(Icons.delete),
            //       iconSize: 30,
            //       onPressed: onPreesDelete,
            //     ),
            //          SizedBox(width: 85,),
            //     IconButton(icon: Icon(Icons.edit),
            //     iconSize: 30,
            //      onPressed: onPreesEdit),
    
            //   ],
            // )
          ],
        ));
  }
}
// ListTile(title:Text("$name",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),subtitle:Text("$date") ,trailing:row)
