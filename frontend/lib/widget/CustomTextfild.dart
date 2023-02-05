import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFild extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) valu;
  final Widget icon;
  const CustomTextFild(
      {super.key,
      required this.hint,
      required this.controller,
      required this.valu,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: valu,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  width: 3, color: Color.fromARGB(255, 249, 249, 249))),
          filled: true,
          fillColor: Color(0xff838C96),
          isDense: true,
          contentPadding: EdgeInsets.all(1),
          prefixIcon: icon,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                width: 5,
              )),
        ),
      ),
    );
  }
}
