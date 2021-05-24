import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopify/Components/Items.dart';
import 'package:shopify/Components/TitleRow.dart';
import 'package:shopify/Screens/auth.dart';
import 'package:shopify/Screens/cart.dart';
import 'package:shopify/Screens/preview.dart';
import 'package:shopify/cart/CartItemCounter.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/Components/item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopify/config/config.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  var selectedGender;
  Box cartItemsList;
  @override
  void initState() {
    super.initState();
    cartItemsList = Hive.box('myCartList');
  }

  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Dee Gadgets",
          style: TextStyle(fontSize: 50.0, fontFamily: 'signatra'),
        ),
        actions: [
          Stack(children: [
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (c) => Cart());
                Navigator.push(context, route);
              },
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: 3.0,
                child:
                    Consumer<CartItemCounter>(builder: (context, counter, _) {
                  return Text(
                    counter.count.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  );
                }))
          ]),
        ],
        centerTitle: true,
      ),
      drawer: ListView(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Hi, " +
                              ECommerceApp.sharedPreferences
                                  .getString(ECommerceApp.userName),
                          style:
                              TextStyle(fontFamily: 'signatra', fontSize: 30.0),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 50.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(
                    Icons.list,
                    color: Colors.black,
                  ),
                  title:
                      Text('My Orders', style: TextStyle(color: Colors.black)),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                  title: Text('My Cart', style: TextStyle(color: Colors.black)),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  onTap: () {
                    ECommerceApp.auth.signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) => Auth(
                                    secondaryColor: dActiveColor,
                                    primaryColor: dActiveColor))));
                  },
                  leading: Icon(
                    Icons.exit_to_app_sharp,
                    color: Colors.black,
                  ),
                  title: Text('Logout', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        SearchBox(),
        Expanded(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              TitleRow(title: "Top Rated"),
              ValueListenableBuilder(
                  valueListenable: cartItemsList.listenable(),
                  builder: (context, Box box, _) {
                    return box.isEmpty
                        ? Center(
                            child: Text('Cart is empty'),
                          )
                        : Container(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Items')
                                    .where('brand', isEqualTo: 'Apple')
                                    .limit(10)
                                    .orderBy('publishDate', descending: true)
                                    .snapshots(),
                                builder: (context, dataSnapshot) {
                                  return !dataSnapshot.hasData
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: height * 0.46,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      ItemModel model =
                                                          ItemModel.fromJson(
                                                              dataSnapshot.data
                                                                  .docs[index]
                                                                  .data());
                                                      return sourceInfo(
                                                          model, context, box);
                                                    },
                                                    itemCount: dataSnapshot
                                                        .data.docs.length),
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                          );
                  }),
              Divider(
                height: 5.0,
              ),
              TitleRow(title: 'Samsung'),
              ValueListenableBuilder(
                  valueListenable: cartItemsList.listenable(),
                  builder: (context, Box box, _) {
                    return box.isEmpty
                        ? Center(
                            child: Text('Cart is empty'),
                          )
                        : StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Items')
                                .where('brand', isEqualTo: 'Samsung')
                                .limit(10)
                                .orderBy('publishDate', descending: true)
                                .snapshots(),
                            builder: (context, dataSnapshot) {
                              return !dataSnapshot.hasData
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: height * 0.46,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  ItemModel model =
                                                      ItemModel.fromJson(
                                                          dataSnapshot
                                                              .data.docs[index]
                                                              .data());
                                                  return sourceInfo(
                                                      model, context, box);
                                                },
                                                itemCount: dataSnapshot
                                                    .data.docs.length),
                                          ),
                                        ),
                                      ],
                                    );
                            });
                  }),
              TitleRow(title: 'Apple'),
              ValueListenableBuilder(
                  valueListenable: cartItemsList.listenable(),
                  builder: (context, Box box, _) {
                    return box.isEmpty
                        ? Center(
                            child: Text('Cart is empty'),
                          )
                        : StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Items')
                                .where('brand', isEqualTo: 'Apple')
                                .limit(10)
                                .orderBy('publishDate', descending: true)
                                .snapshots(),
                            builder: (context, dataSnapshot) {
                              return !dataSnapshot.hasData
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: height * 0.46,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  ItemModel model =
                                                      ItemModel.fromJson(
                                                          dataSnapshot
                                                              .data.docs[index]
                                                              .data());
                                                  return sourceInfo(
                                                      model, context, box);
                                                },
                                                itemCount: dataSnapshot
                                                    .data.docs.length),
                                          ),
                                        ),
                                      ],
                                    );
                            });
                  })
            ],
          ),
        ),
      ]),
    );
  }
}

void checkItemInCart(String shortInfoAsID, BuildContext context) {
  ECommerceApp.sharedPreferences
          .getStringList(ECommerceApp.userCartList)
          .contains(shortInfoAsID)
      ? Fluttertoast.showToast(
          msg: 'Item is already in Cart',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0)
      : addItemToCart(shortInfoAsID, context);
}

addItemToCart(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      ECommerceApp.sharedPreferences.getStringList(ECommerceApp.userCartList);
  tempCartList.add(shortInfoAsID);

  ECommerceApp.firestore
      .collection(ECommerceApp.collectionUser)
      .doc(ECommerceApp.sharedPreferences.getString(ECommerceApp.userUID))
      .update({
    ECommerceApp.userCartList: tempCartList,
  }).then((value) => Fluttertoast.showToast(
          msg: "Item Added to Cart Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0));
  ECommerceApp.sharedPreferences
      .setStringList(ECommerceApp.userCartList, tempCartList);
  Provider.of<CartItemCounter>(context, listen: false).displayResult();
}

Widget sourceInfo(ItemModel model, BuildContext context, Box box,
    {Color background, removeCartFunction}) {
  return GestureDetector(
    onTap: () {
      showBottomSheet(
          context: context,
          builder: (context) => Preview(
              launchWhatsapp: () {},
              title: model.title,
              buttonText: 'ADD TO CART',
              imageTitle: model.thumbnailUrl,
              price: model.price,
              description: model.longDescription,
              onTap: () {
                checkItemInCart(model.shortInfo, context);
              }));
    },
    child: ItemCard(
        onTap: () {
          print(box.length);
          checkItemInCart(model.shortInfo, context);
        },
        percent: 9,
        title: model.title,
        imageTitle: model.thumbnailUrl,
        price: model.price,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 30.0,
            color: Colors.black,
          ),
        )),
  );
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          showSearch(context: context, delegate: SearchBoxDelegate());
        },
        child: Container(
          decoration: BoxDecoration(
            color: dActiveColor,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          child: InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black38,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Search',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

class SearchBoxDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query;
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        child: Center(
      child: Text(
        query,
        style: TextStyle(color: Colors.black),
      ),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
