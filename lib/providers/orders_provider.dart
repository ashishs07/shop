import 'package:flutter/material.dart';

import '../models/cart.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> cartItems;
  final DateTime date;

  OrderItem({
    @required this.id,
    @required this.totalAmount,
    @required this.cartItems,
    @required this.date,
  });
}

class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(double totalAmount, List<CartItem> cartItems) {
    if (totalAmount != 0.0) {
      _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            totalAmount: totalAmount,
            cartItems: cartItems,
            date: DateTime.now()),
      );
    }
    notifyListeners();
  }
}
