

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class CustomButton extends StatelessWidget {
  final void Function()? onPress;
  final String text;
  const CustomButton({super.key, this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(20),
        child: ElevatedButton(
         style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF64372A),
                        primary: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
          
      onPressed: onPress,
      child: Text(
         "$text",
       
      ),
    ));
  }
}
