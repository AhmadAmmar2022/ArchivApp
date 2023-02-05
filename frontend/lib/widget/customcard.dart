import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class customCard extends StatelessWidget {
  void Function()? onTap;
  final String name;
  final String date;
  final void Function()   ?onPreesEdit ;
   final void Function()  ?onPreesDelete ;
  customCard({
    Key? key,
    required this.onTap,
    required this.name,
    required this.date,
   required this.onPreesEdit,
    this.onPreesDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
                width: 4, color: const Color.fromARGB(255, 105, 84, 21)),
            borderRadius: BorderRadius.circular(12),
          ),
          width: 200,
          height: 200,
          child: Column(
            children: [
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
              SizedBox(height: 105,),
              Row(
                children:
                  [
                      IconButton(
                    icon: Icon(Icons.delete),
                    iconSize: 30,
                    onPressed: onPreesDelete,
                  ),
                       SizedBox(width: 85,),
                  IconButton(icon: Icon(Icons.edit),    
                  iconSize: 30,
                   onPressed: onPreesEdit),
             
                
                ],
              )
            ],
          )),
      onTap: onTap,
    );
  }
}
// ListTile(title:Text("$name",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),subtitle:Text("$date") ,trailing:row)