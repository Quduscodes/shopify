import 'package:flutter/material.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/Components/GenderReusableCard.dart';

class ActiveWear extends StatefulWidget {
  @override
  _ActiveWearState createState() => _ActiveWearState();
}

class _ActiveWearState extends State<ActiveWear> {
  var selectedMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kInActiveCardColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'ACTIVE WEAR',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left_outlined,
              size: 50.0,
              color: Colors.black,
            )),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GenderReusableCard(
                      textColor: Colors.black,
                      gender: 'SORT',
                      onPress: () {
                        selectedMode = Mode.sort;
                      },
                      color: Colors.white),
                ),
                Container(
                  width: 4.0,
                  height: 50.0,
                  color: kInActiveCardColor,
                ),
                Expanded(
                  child: GenderReusableCard(
                      textColor: Colors.black,
                      gender: 'FILTER',
                      onPress: () {
                        setState(() {
                          selectedMode = Mode.filter;
                        });
                      },
                      color: Colors.white),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
