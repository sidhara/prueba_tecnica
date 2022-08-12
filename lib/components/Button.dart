// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double borderRadius;
  final Function()? onTap;
  const Button({Key? key, required this.backgroundColor, required this.textColor, required this.text, this.onTap, required this.borderRadius}) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: widget.onTap,
      backgroundColor: widget.backgroundColor,
      label: Text(widget.text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius)
      )
    );
  }
}