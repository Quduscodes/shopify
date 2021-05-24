import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify/Screens/auth.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/Components/credentials.dart';
import 'package:shopify/Components/sign_in_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopify/Components/error_dialog.dart';
import 'package:shopify/admin/uploaditems.dart';


class AdminSignInPage extends StatefulWidget {
  @override
  _AdminSignInPageState createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  bool showSpinner = false;
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _adminIDTextEditingController =
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
                  height: 30.0,
                ),
                Credentials(
                  data: Icons.person,
                  controller: _adminIDTextEditingController,
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  text: 'Admin ID',
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
                    _adminIDTextEditingController.text.isNotEmpty &&
                            _passwordTextEditingController.text.isNotEmpty
                        ? loginAdmin()
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
                    style: ElevatedButton.styleFrom(primary: dActiveColor),
                    label: Text('I am not admin'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Auth(
                                secondaryColor: dActiveColor,
                                primaryColor: dActiveColor))),
                    icon: (Icon(Icons.nature_people)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    setState(() {
      showSpinner = true;
    });
    FirebaseFirestore.instance.collection('admins').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != _adminIDTextEditingController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('ID or Password incorrect')),);
        } else if (result.data()['password'] !=
            _passwordTextEditingController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('ID or Password incorrect')));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Welcome '+result.data()['name'])));
          setState(() {
            _passwordTextEditingController.text = '';
            _adminIDTextEditingController.text = '';
          });

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadPage()));
        }
      });
    });
  }
}
