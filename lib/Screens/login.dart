import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify/config/config.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/Components/credentials.dart';
import 'package:shopify/Components/sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopify/Components/error_dialog.dart';
import 'package:shopify/admin/Admin_Signin.dart';
import 'package:shopify/Screens/StoreHome.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Box cartItemsList;

  @override
  void initState() {
    super.initState();
    cartItemsList = Hive.box('myCartList');
  }

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: cartItemsList.listenable(),
            builder: (context, Box box, _) {
              return Container(
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
                        height: 30.0,
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
                        data: Icons.person,
                        controller: _passwordTextEditingController,
                        obscureText: true,
                        text: 'Password',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedButton(
                        text: 'Login',
                        color: dActiveColor,
                        press: () {
                          _emailTextEditingController.text.isNotEmpty &&
                                  _passwordTextEditingController.text.isNotEmpty
                              ? loginUser()
                              : showDialog(
                                  context: context,
                                  builder: (c) {
                                    return ErrorDialogue(
                                        message:
                                            'Please ensure that you have filled the form correctly');
                                  });
                        },
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: dActiveColor),
                          label: Text('Login as admin'),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminSignInPage())),
                          icon: (Icon(Icons.nature_people)))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  loginUser() async {
    setState(() {
      showSpinner = true;
    });
    User user;
    await _auth
        .signInWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((authUser) {
      user = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialogue(message: error.message.toString());
          });
    });

    Future readData(User fUser) async {
      FirebaseFirestore.instance
          .collection("users")
          .doc(fUser.uid)
          .get()
          .then((dataSnapshot) async {
        await ECommerceApp.sharedPreferences
            .setString("uid", dataSnapshot.data()[ECommerceApp.userUID]);

        await ECommerceApp.sharedPreferences.setString(ECommerceApp.userEmail,
            dataSnapshot.data()[ECommerceApp.userEmail]);
        await ECommerceApp.sharedPreferences.setString(
            ECommerceApp.userName, dataSnapshot.data()[ECommerceApp.userName]);

        List<String> cartList =
            dataSnapshot.data()[ECommerceApp.userCartList].cast<String>();
        await ECommerceApp.sharedPreferences
            .setStringList(ECommerceApp.userCartList, cartList);

        ECommerceApp.cartList.put('cartItems', cartList);
      });
    }

    if (user != null) {
      readData(user).then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StoreHome()));
      });
    }
  }
}
