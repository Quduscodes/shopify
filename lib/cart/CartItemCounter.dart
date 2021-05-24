import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shopify/config/config.dart';
class CartItemCounter with ChangeNotifier{
int _counter = ECommerceApp.sharedPreferences.getStringList(ECommerceApp.userCartList).length;
int get count => _counter;

Future<void> displayResult() async{
  int _counter = ECommerceApp.sharedPreferences.getStringList(ECommerceApp.userCartList).length;
  await Future.delayed(const Duration(microseconds: 100),(){
    notifyListeners();
  });
}

}