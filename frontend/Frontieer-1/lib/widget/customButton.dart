

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
      padding: EdgeInsets.all(20),
        child: MaterialButton(
      textColor: Colors.white,
      color: Color.fromARGB(255, 252, 151, 0),
      onPressed: onPress,
      child: Text(
         "$text",
         style: Theme.of(context).textTheme.headline6,
      ),
    ));
  }
}
