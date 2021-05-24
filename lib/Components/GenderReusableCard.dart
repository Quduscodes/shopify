import 'package:flutter/material.dart';

class GenderReusableCard extends StatelessWidget {
  final onPress;
  final gender;
  final color;
  final textColor;

  GenderReusableCard({@required this.textColor, @required this.onPress,@required this.color, this.gender,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(22.0),
        child: Center(
          child: Text(gender, style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25.0,
            color: textColor,
          ),),
        ),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
