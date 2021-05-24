// import 'package:flutter/cupertino.dart';
// import 'package:shopify/Components/Items.dart';
//
// class ItemsData with ChangeNotifier {
//   double totPrice = 0;
//
//   List<Items> _items = [
//     Items(
//       quantity: 1,
//       id: 0,
//       description:
//           'I don\'t really know what to write here but this is description 1',
//       imageTitle: 'assets/Totebag.jpg',
//       price: 75.99,
//     ),
//     Items(
//       quantity: 1,
//       id: 0,
//       description:
//           'I don\'t really know what to write here but this is description 2',
//       imageTitle: 'assets/adidas.jpg',
//       price: 45.99,
//     ),
//     Items(
//       quantity: 1,
//       id: 0,
//       description:
//           'I don\'t really know what to write here but this is description 3',
//       imageTitle: 'assets/nike.jpg',
//       price: 60.00,
//     )
//   ];
//
//   List<Items> _favorites = [];
//   List<Items> get favorites => this._favorites;
//   List<Items> get items => this._items;
//
//   void id(Items item, int index) {
//     item.getId(index);
//     notifyListeners();
//   }
//
//   void updateCart(Items item) {
//     item.toggleFavorite();
//     item.favorite?favorites.add(item):favorites.remove(item);
//     notifyListeners();
//   }
//
//   void updateQuantity(Items item, newQuantity){
//     item.quantity = newQuantity;
//     notifyListeners();
//   }
//
//
//
//   double totalPrice() {
//     double price = 0;
//     for (int i = 0; i < favorites.length; i++) {
//       price += favorites[i].price*favorites[i].quantity;
//     }
//     totPrice = price;
//     return totPrice;
//   }
// }
