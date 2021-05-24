import 'package:flutter/material.dart';
import 'package:shopify/Components/constants.dart';

class TitleRow extends StatelessWidget {
  final title;
  TitleRow({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'SHOP NOW   >',
              style: TextStyle(
                fontSize: 20.0,
                color: dLightActiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
