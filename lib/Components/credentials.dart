import 'package:flutter/material.dart';
import 'package:shopify/Components/constants.dart';

class Credentials extends StatelessWidget {
  final textInputType;
  final text;
  final obscureText;
  final onChanged;
  final controller;
  final IconData data;

  Credentials({
    this.data,
    this.controller,
    this.onChanged,
    this.textInputType,
    @required this.obscureText,
    @required this.text,
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(data, color: dActiveColor,),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: dLightActiveColor, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
              borderSide: BorderSide(color: dLightActiveColor, width: 1.0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          hintText: text,
        ),
      ),
    );
  }


}

