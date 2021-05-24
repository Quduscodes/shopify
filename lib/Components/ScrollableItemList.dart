// import 'package:flutter/material.dart';
// import 'item_card.dart';
// import 'items_data.dart';
// import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';
// import 'package:shopify/Screens/preview.dart';
//
// class ScrollableItemList extends StatefulWidget {
//    ScrollableItemList({@required this.height, this.onTap});
//   final onTap;
//   final double height;
//
//   @override
//   _ScrollableItemListState createState() => _ScrollableItemListState();
// }
//
// class _ScrollableItemListState extends State<ScrollableItemList> {
//   @override
//   Widget build(BuildContext context) {
//     final itemsData = Provider.of<ItemsData>(context);
//     return Row(children: [
//       Expanded(
//           child: SizedBox(
//               height: widget.height * 0.46,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: itemsData.items.length,
//                   itemBuilder: (
//                     context,
//                     index,
//                   ) {
//                     return GestureDetector(
//                       onTap: () {
//                         showBottomSheet(
//                             context: context,
//                             builder: (context) => Preview(
//                               buttonText: 'ADD TO CART',
//                               onTap: (){itemsData.updateCart(itemsData.items[index]);},
//                                   description:
//                                       itemsData.items[index].description,
//                                   price: itemsData.items[index].price,
//                                   imageTitle: itemsData.items[index].imageTitle,
//                                 ));
//                       },
//                       child: ItemCard(
//                           child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               child: Icon(
//                                 Icons.shopping_cart_outlined,
//                                 size: 30.0,
//                                 color: Colors.black,
//                               )),
//                           onTap: () {
//                             itemsData.updateCart(itemsData.items[index]);
//                             print(itemsData.items[index].favorite);
//                             itemsData.id(itemsData.items[index], index);
//                             print(itemsData.items[index].id);
//                           },
//                           imageTitle: itemsData.items[index].imageTitle,
//                           price: itemsData.items[index].price,
//                           description: itemsData.items[index].description),
//                     );
//                   })))
//     ]);
//   }
// }
// // Items(
// // description: itemsData.items[index].description,
// // imageTitle: itemsData.items[index].imageTitle,
// // price: itemsData.items[index].price)
