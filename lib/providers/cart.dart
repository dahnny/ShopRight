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
    return {..._items};
  }

  //This goes through the items in the map and gets the total amountadpblklbkbllb
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
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

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
   if(!_items.containsKey(productId)){
     return;
   }
   if(_items[productId].quantity > 1) {
     _items.update(
         productId,
             (existingCartItem) =>
             CartItem(
                 id: existingCartItem.id,
                 price: existingCartItem.price,
                 quantity: existingCartItem.quantity - 1,
                 title: existingCartItem.title));
   }else{
     _items.remove(productId);
   }
   notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }
}
