import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final DateTime dateTime;
  final List<CartItem> items;
  final double amount;

  OrderItem({@required this.id,
    @required this.dateTime,
    @required this.items,
    @required this.amount});
}

class Orders extends ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url = "https://shopapp-de764.firebaseio.com/orders.json";
    try {
      final response = await http.get(url);
//      get the body of the response which returns a map containing the id and the  body
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<OrderItem> orders = [];
//      go through each element in the map and then set the parameters for it
      extractedData.forEach((orderId, orderData) {
        orders.add(OrderItem(id: orderData['id'],
            dateTime: DateTime.parse(orderData['dateTime']),
//            set the cartItems as a list and go through it to get each item
            items: (orderData['items'] as List<dynamic>).map((item) =>
                CartItem(id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'])).toList(),
            amount: orderData['amount']));
      });

      _orders = orders.reversed.toList();
      notifyListeners();
    }catch (error){
      throw error;
    }
  }

  Future<void> addOrders(List<CartItem> cartProducts, double total) async {
    const url = "https://shopapp-de764.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'dateTime': timeStamp.toIso8601String(),
//            go through each cartProduct and store it as a map
            'items': cartProducts
                .map((e) =>
            {
              'id': e.id,
              'title': e.title,
              'quantity': e.quantity,
              'price': e.price
            })
                .toList(),
            'amount': total
          }));

      final newOrder = OrderItem(
          id: json.decode(response.body)['name'],
          dateTime: timeStamp,
          items: cartProducts,
          amount: total);

      _orders.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
