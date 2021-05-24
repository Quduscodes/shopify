import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopify/Components/constants.dart';
import 'package:intl/intl.dart';

class Preview extends StatelessWidget {
  final imageTitle;
  final price;
  final description;
  final onTap;
  final launchWhatsapp;
  final title;
  final buttonText;
  Preview(
      {this.launchWhatsapp,
        this.title,
      this.buttonText,
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
      color: dActiveColor,
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        height: 900,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ListView(children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      width: width * 0.75,
                      child: FittedBox(
                        child: Image.network(imageTitle),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'General Description',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Text(
                      description,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Text(
                      '₦' + formatCurrency.format(price).toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 28.0),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                          backgroundColor: Colors.green,
                          child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.call_outlined,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  onPressed:launchWhatsapp))),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onTap,
                        child: Container(
                            margin: EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: height * 0.05,
                            decoration: BoxDecoration(color: dActiveColor),
                            child: Center(
                                child: Text(
                              buttonText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
