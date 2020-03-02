import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
//    This returns all items
    return {...items};
  }

  void addItem(String productId, double price, String title) {
//    This checks if the map contains a particular key
    if (_items.containsKey(productId)) {
//      .update checks for a particular productId and returns a function
//      that can be edited
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
//              Add one to the current quantity if the productId exists
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
//      .putIfAbsent returns a function if the key to the map was not found
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }
}
