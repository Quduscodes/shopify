import 'package:flutter/material.dart';

enum Gender { male, female }
enum Mode { sort, filter }
const kBottomContainerHeight = 80.0;
const kInActiveCardColor = Color(0xfff1f1f1);
const dLightActiveColor = Colors.redAccent;
const dActiveColor = Colors.red;

int _selectedItem = 0;
BottomNavigationBar buildBottomNavigationBar( onTap, ) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.alternate_email_outlined), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: '')
    ],
    unselectedItemColor: Colors.grey[700],
    currentIndex: _selectedItem,
    selectedItemColor: dActiveColor,
    onTap: onTap,
  );
}

