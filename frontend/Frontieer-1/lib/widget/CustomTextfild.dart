import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFild extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
   final String? Function(String?) valu ;
  const CustomTextFild({super.key, required this.hint, required this.controller, required this.valu});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valu,
    controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText:hint, 
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: BorderSide(width: 5, color: Colors.red))),
    );
  }
}