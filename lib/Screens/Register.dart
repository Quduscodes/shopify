import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/Components/credentials.dart';
import 'package:shopify/Components/error_dialog.dart';
import 'package:shopify/Components/sign_in_button.dart';
import 'package:shopify/Components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopify/config/config.dart';
import 'package:shopify/Screens/StoreHome.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showSpinner = false;

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(30.0),
                      height: height * 0.35,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.asset('assets/deelogo.png'))),
                  SizedBox(
                    height: 10.0,
                  ),
                  Credentials(
                    data: Icons.person,
                    controller: _nameTextEditingController,
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    text: 'Full Name',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Credentials(
                    data: Icons.email,
                    controller: _emailTextEditingController,
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    text: 'Email',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Credentials(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    obscureText: true,
                    text: 'Password',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Credentials(
                    controller: _cPasswordTextEditingController,
                    data: Icons.person,
                    obscureText: true,
                    text: 'Confirm password',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RoundedButton(
                    text: 'Register',
                    color: dActiveColor,
                    press: () async {
                      checkForm();
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> checkForm() async {
    if (_passwordTextEditingController.text !=
        _cPasswordTextEditingController.text) {
      displayDialogue('Passwords do not match');
    } else if (_emailTextEditingController.text.isEmpty &&
        _passwordTextEditingController.text.isEmpty&&_nameTextEditingController.text.isEmpty) {
      displayDialogue('Please ensure that you have filled the form correctly');
    } else {
      setState(() {
        showSpinner = true;
      });
      _registerUser();
    }
  }

  displayDialogue(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorDialogue(message: msg);
        });
  }

  final _auth = FirebaseAuth.instance;
  void _registerUser() async {
    User user;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((auth) {
      user = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialogue(message: error.message.toString());
          });
    });
    if (user != null) {
      saveUserInfoToFirestore(user).then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StoreHome()));
      });
    }
  }

  Future saveUserInfoToFirestore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      ECommerceApp.userCartList: ['dummy text'],
    });
    await ECommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await ECommerceApp.sharedPreferences
        .setString(ECommerceApp.userEmail, fUser.email);
    await ECommerceApp.sharedPreferences
        .setStringList(ECommerceApp.userCartList, ['dummy text']);
    await ECommerceApp.sharedPreferences
        .setString(ECommerceApp.userName, _nameTextEditingController.text);
  }
}
