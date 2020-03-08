import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final DateTime dateTime;
  final List<CartItem> items;
  final double amount;

  OrderItem(
      {@required this.id,
      @required this.dateTime,
      @required this.items,
      @required this.amount});
}

class Orders extends ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            dateTime: DateTime.now(),
            items: cartProducts,
            amount: total));

    notifyListeners();
  }


}
