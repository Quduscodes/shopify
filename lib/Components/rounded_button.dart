import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  final onPressed;
  final icon;
  RoundedButton({this.onPressed, this.icon});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon, color: Colors.black,),
      constraints: BoxConstraints.tightFor(
        height: 45.0,
        width: 45.0,
      ),
      elevation: 2.0,
      shape: CircleBorder(),
      fillColor: Colors.white,
    );
  }
}
