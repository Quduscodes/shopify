import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final text;
  final color;
  final press;

  RoundedButton({
    this.text,
    this.color,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
          width: size.width * 0.8,
          height: 45.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }
}
