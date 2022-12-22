import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class customCard extends StatelessWidget {
  void Function()? onTap;
  final String name;
  final String date;
  final Widget row;
  customCard({
    Key? key,
    required this.onTap,
    required this.name,
    required this.date,
    required this.row,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Color.fromARGB(255, 105, 84, 21)),
          borderRadius: BorderRadius.circular(12),
        ),
        width: 200,
        height: 200,
        child: Text(
          "$name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
        ),
      ),
      onTap: onTap,
    );
  }
}
// ListTile(title:Text("$name",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),subtitle:Text("$date") ,trailing:row)