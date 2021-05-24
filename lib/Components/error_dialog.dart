import 'package:flutter/material.dart';
import 'package:shopify/Components/constants.dart';

class ErrorDialogue extends StatelessWidget {
  final String message;
  ErrorDialogue({this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: dActiveColor,
          ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Text('OK'),
            ))
      ],
    );
  }
}
