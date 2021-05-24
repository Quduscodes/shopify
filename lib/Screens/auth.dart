import 'package:flutter/material.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/Components/sign_in_button.dart';
import 'package:shopify/Screens/Register.dart';
import 'package:shopify/screens/Login.dart';

class Auth extends StatelessWidget {
  static const String id = 'Welcome_Screen';
  Auth({
    @required this.secondaryColor,
    @required this.primaryColor,
  });

  final secondaryColor;
  final primaryColor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30.0),
                height: height * 0.35,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset('assets/deelogo.png'))),
            SizedBox(
              height: 50.0,
            ),
            Column(
              children: <Widget>[
                RoundedButton(
                    text: 'Login',
                    color: dActiveColor,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }),
                SizedBox(
                  height: 10.0,
                ),
                RoundedButton(
                  text: 'Register',
                  color: dActiveColor,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
