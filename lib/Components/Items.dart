import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String thumbnailUrl;
  int price;
  String longDescription;
  String shortInfo;
  String status;
 String title;
 Timestamp publishDate;
String brand;
int quantity;
  ItemModel(
      {this.shortInfo,
      this.thumbnailUrl,
      this.longDescription,
      this.title,
      this.publishDate,
      this.price,
      this.status,
      this.brand,
      this.quantity,
      });

  ItemModel.fromJson(Map<String, dynamic> json)
      {title = json['title'];
      shortInfo = json['shortInfo'];
      publishDate = json['publishDate'];
      thumbnailUrl = json['thumbnailUrl'];
       longDescription = json['longDescription'];
      status = json['status'];
      price = json['price'];
      brand = json['brand'];
      quantity = json['quantity'];
      }


}
