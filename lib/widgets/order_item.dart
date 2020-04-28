import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(widget.order.items.length * 20.0 + 120, 240) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("\$${widget.order.amount}"),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                  icon: _expanded
                      ? Icon(Icons.expand_more)
                      : Icon(Icons.expand_less),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  }),
            ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  height: _expanded ? min(widget.order.items.length * 20.0 + 20, 100) : 0,
                  child: ListView(
                      children: widget.order.items
                          .map((prod) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    prod.title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${prod.quantity}x \$${prod.price}",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  )
                                ],
                              ))
                          .toList()))
          ],
        ),
      ),
    );
  }
}
