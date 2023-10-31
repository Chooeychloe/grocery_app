import 'package:flutter/material.dart';
import 'package:textless/textless.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: onPressed,
      color: Colors.black,
      child: text.s1.bold.color(Colors.white),
    );
  }
}
