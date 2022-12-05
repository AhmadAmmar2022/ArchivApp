import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../Auth/login.dart';

class customText extends StatelessWidget {
 final  void Function()? onPress;
 final String text ;
  const customText({super.key, this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            Text("$text"),
            InkWell(
              onTap: onPress,
              child: Text(
                "Click Here",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ));
  }
}