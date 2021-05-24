import 'package:flutter/material.dart';
import 'package:shopify/Screens/StoreHome.dart';
import 'package:shopify/cart/ItemQuantity.dart';
import 'package:shopify/cart/changeAddress.dart';
import 'package:shopify/cart/totalAmount.dart';
import 'package:shopify/config/config.dart';
import 'package:shopify/Components/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:shopify/Screens/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify/cart/CartItemCounter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  await Hive.openBox('myCartList');
  await Firebase.initializeApp();
  ECommerceApp.auth = FirebaseAuth.instance;
  ECommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  ECommerceApp.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _initialization, builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text(('something has occurred'));
      }
      if (snapshot.connectionState == ConnectionState.done) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create:(c) => CartItemCounter()),
            ChangeNotifierProvider(create:(c) => TotalAmount()),
            ChangeNotifierProvider(create:(c) => AddressChanger()),
            ChangeNotifierProvider(create:(c) => ItemQuantity()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: dActiveColor,
              accentColor: dActiveColor,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      }
      return MaterialApp(
          theme: ThemeData(
              accentColor: dActiveColor
          ),
          home: SplashScreen());
    });}
}



class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    displaySplash();
  }

  displaySplash(){
    Timer(Duration(seconds: 5), () {
      if( ECommerceApp.auth.currentUser != null){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>StoreHome()));
    }else{
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Auth(secondaryColor: dActiveColor, primaryColor: dActiveColor)));

    }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: width*0.3,
                          height: height*0.3,
                          child: FittedBox(
                            child: Image.asset('assets/deelogo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        "Welcome to DEE GADGETS",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text(
                        "Online Gadgets Store \n         For Everyone",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
  }
}
