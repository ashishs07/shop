import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final String totalAmount;
  final String cartItems;
  final DateTime date;

  OrderItem({
    @required this.id,
    @required this.totalAmount,
    @required this.cartItems,
    @required this.date,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'totalAmount': totalAmount,
        'cartItems': cartItems,
        'date': date.toIso8601String(),
      };
}
