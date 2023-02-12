import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class customCard extends StatelessWidget {
  var size, height, width;
  void Function()? onTap;
  final String name;
  final Color color;
  final void Function()? onPreesEdit;
  final void Function()? onPreesDelete;
  customCard({
    Key? key,
    required this.onTap,
    required this.name,
    required this.color,
    required this.onPreesEdit,
    this.onPreesDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
          margin: EdgeInsets.all(2),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.folder),
                  onPressed: () {},
                  iconSize: 60,
                  color:color ,
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
          )),
      onTap: onTap,
    );
  }
}
// ListTile(title:Text("$name",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),subtitle:Text("$date") ,trailing:row)
