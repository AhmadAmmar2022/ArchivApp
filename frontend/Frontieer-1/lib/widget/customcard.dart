
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class customCard extends StatelessWidget {
  void Function()? onTap;
  final String name;
  final String date;
   customCard({ 
    Key? key,
   required this.onTap, required this.name, required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
      
        child: Card(
          elevation: 5,
          child: ListTile(title:Text("$name",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),subtitle:Text("$date") ,)),
      ) ,     
      onTap: onTap,
    );
  }
}
