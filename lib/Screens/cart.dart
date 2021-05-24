import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopify/Components/Items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopify/Components/constants.dart';
import 'package:shopify/config/config.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cart extends StatefulWidget {
  ItemModel itemModel;
  Cart({this.itemModel});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Box cartItemsList;

  @override
  void initState() {
    super.initState();
    cartItemsList = Hive.box('myCartList');
  }

  int newQuantity = 1;
  final formatCurrency = new NumberFormat();

  String cartItemID;
  @override
  Widget build(BuildContext context) {
    // ECommerceApp.sharedPreferences.getStringList(ECommerceApp.userCartList)
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'Shopping Cart',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 23.0),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
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
                        .where('shortInfo', whereIn: box.get('cartItems'))
                        .limit(10)
                        .orderBy('publishDate', descending: true)
                        .snapshots(),
                    builder: (context, dataSnapshot) {
                      return !dataSnapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        ItemModel model = ItemModel.fromJson(
                                            dataSnapshot.data.docs[index]
                                                .data());
                                        return Container(
                                          margin: EdgeInsets.all(20.0),
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: sourceInfo(
                                                      model, context)),
                                              SizedBox(width: 10.0),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(model.title,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  color: Colors
                                                                      .black87)),
                                                          IconButton(
                                                              icon: Icon(
                                                                  Icons.close),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  ECommerceApp
                                                                      .sharedPreferences
                                                                      .remove(ECommerceApp
                                                                          .sharedPreferences
                                                                          .getStringList(
                                                                              ECommerceApp.userCartList)[index]);
                                                                });
                                                                print(ECommerceApp
                                                                    .sharedPreferences
                                                                    .getStringList(
                                                                        ECommerceApp
                                                                            .userCartList)[0]);
                                                                print(ECommerceApp
                                                                    .sharedPreferences
                                                                    .getStringList(
                                                                        ECommerceApp
                                                                            .userCartList)[1]);
                                                                print(box.get(
                                                                    'cartItems'));
                                                              })
                                                        ],
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        '₦' +
                                                            formatCurrency
                                                                .format(
                                                                    newQuantity *
                                                                        model
                                                                            .price)
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20.0),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          roundedButton(() {
                                                            setState(() {
                                                              newQuantity = model
                                                                  .quantity--;
                                                            });
                                                          }, Icons.remove),
                                                          Text(
                                                            newQuantity
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 20.0),
                                                          ),
                                                          roundedButton(() {
                                                            setState(() {
                                                              newQuantity = model
                                                                  .quantity++;
                                                            });
                                                          }, Icons.add)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: dataSnapshot.data.docs.length),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: 15.0, right: 15.0, left: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: dActiveColor),
                                          ),
                                        )),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              primary: dActiveColor,
                                            ),
                                            onPressed: () {},
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.0,
                                                    vertical: 20.0),
                                                child: Text(
                                                  'Checkout',
                                                  style:
                                                      TextStyle(fontSize: 25.0),
                                                )),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            );
                    }),
              );
            }));
  }


  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    return Container(
      child: FittedBox(
        child: Image.network(model.thumbnailUrl),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget roundedButton(Function onPressed, IconData icon) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(icon),
      constraints: BoxConstraints.tightFor(
        height: 35.0,
        width: 35.0,
      ),
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor: Colors.white70,
    );
  }
}
//     final favorites = Provider.of<ItemsData>(context).favorites;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         backgroundColor: kInActiveCardColor,
//         appBar: AppBar(
//           title: Text(
//             'CART',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//           ),
//           backgroundColor: Colors.white,
//           centerTitle: true,
//         ),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: favorites.isEmpty
//                   ? Center(
//                       child: Text(
//                         'Cart is Empty',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 32),
//                       ),
//                     )
//                   : Container(
//                 margin: EdgeInsets.all(7.0),
//                       child: ListView.builder(
//                           itemCount:
//                               Provider.of<ItemsData>(context).favorites.length,
//                           itemBuilder: (
//                             context,
//                             index,
//                           ) {
//                             return Row(
//                               children: [
//                                 ItemCard(
//                                     child: Container(),
//                                     onTap: () {
//                                       print(favorites[index].imageTitle);
//                                     },
//                                     imageTitle: favorites[index].imageTitle,
//                                     price: favorites[index].price,
//                                     description: favorites[index].description),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         RoundedButton(
//                                           icon: Icons.remove,
//                                           onPressed: () {
//                                             newQuantity--;
//                                             Provider.of<ItemsData>(context, listen: false).updateQuantity(favorites[index], newQuantity);
//
//                                           },
//                                         ),
//                                         SizedBox(width: 7.0),
//                                         Container(child:Text(favorites[index].quantity.toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),)),
//                                         SizedBox(width: 7.0),
//                                         RoundedButton(
//                                           icon: Icons.add,
//                                           onPressed: () {
//                                             newQuantity++;
//                                             Provider.of<ItemsData>(context, listen: false).updateQuantity(favorites[index], newQuantity);
//                                           },
//                                         )
//                                       ],
//                                     ),
//                                     Text('Unit price'),
//                                   ],
//                                 ),
//                               ],
//                             );
//                           }),
//                     ),
//             ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                       margin: EdgeInsets.all(10.0),
//                       height: height * 0.03,
//                       child: favorites.isEmpty
//                           ? Text('TOTAL PRICE: 0.0',
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.w600))
//                           : Text(
//                               'TOTAL PRICE:  ${Provider.of<ItemsData>(context).totalPrice().toStringAsFixed(2)}',
//                               style: TextStyle(
//                                   fontSize: 25, fontWeight: FontWeight.w600))),
//                   Container(
//                     margin: EdgeInsets.all(15.0),
//                     padding: EdgeInsets.all(5.0),
//                     height: height * 0.04,
//                     color: Colors.black,
//                     child: GestureDetector(
//                       onTap: () {
//                         Provider.of<ItemsData>(context, listen: false)
//                             .totalPrice();
//                       },
//                       child: Text(
//                         'CHECKOUT',
//                         style: TextStyle(color: Colors.white, fontSize: 20.0),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }
