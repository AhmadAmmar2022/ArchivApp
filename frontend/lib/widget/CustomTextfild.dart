import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFild extends StatelessWidget {
  final String hint;
  final Color fillColor;
  final TextEditingController controller;
  final Function(String)? onChanged; // بدل valu
  final Widget icon;

  const CustomTextFild({
    super.key,
    required this.hint,
    required this.controller,
    required this.onChanged,
    required this.icon,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 10, 5),
      child: TextFormField(
        onChanged: onChanged, // استخدم onChanged بدلاً من validator
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(255, 249, 249, 249))),
          filled: true,
          fillColor: fillColor,
          isDense: true,
          contentPadding: EdgeInsets.zero,
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
