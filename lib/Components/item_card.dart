import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopify/Components/constants.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final imageTitle;
  final description;
  final price;
  final onTap;
  final child;
  final title;
  final percent;

  ItemCard(
      {this.percent,
      this.title,
      this.child,
      this.price,
      this.description,
      this.imageTitle,
      this.onTap});
  final formatCurrency = new NumberFormat();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width * 0.6,
        margin: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFffdede),
              offset: Offset(3.0, 3.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: height * 0.3,
                  width: width * 0.7,
                  child: FittedBox(
                    child: Image.network(imageTitle),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    bottom: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: onTap,
                      child: child,
                    ))
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: width * 0.5,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: Center(
                        child: Text(
                      '-' + percent.toString() + '%',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0,
                          color: Colors.white),
                    )),
                    width: 45.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.green),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('₦' + formatCurrency.format(price).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 30.0,
                              color: dActiveColor)),
                      Text('₦' + formatCurrency.format(price * 1.1).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25.0,
                              color: Colors.black45,
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
