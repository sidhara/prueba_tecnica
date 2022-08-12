// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/components/Colors.dart';

class TextFieldCustom extends StatefulWidget {
  final String text;
  final bool password;
  final TextEditingController controller;

  const TextFieldCustom({Key? key, required this.text, required this.controller, required this.password, }) : super(key: key);

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {

  late bool hidden;

  @override
  void initState() {
    super.initState();
    hidden=widget.password?true:false;
  }

  @override
  Widget build(BuildContext context) {
      return TextFormField(
        cursorColor: AppColor.green,
        keyboardType: widget.password ? null : const TextInputType.numberWithOptions(signed: true),
        obscureText: hidden,
        obscuringCharacter: "•",
        controller: widget.controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.black, 
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)
          ),
          labelText: widget.text,
          suffixIcon: widget.password ? IconButton(
            color: AppColor.green,
            icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
            onPressed: (){
              setState(() {
                hidden=!hidden;
              });
            },
          ) : null
        ),
      );
  }
}