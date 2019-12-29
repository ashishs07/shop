import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final String token;
  final String userId;

  OrderProvider(this.token, this.userId, this._orders);

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    try {
      final url =
          'https://shopapp-695d8.firebaseio.com/orders/$userId.json?auth=$token';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        final order = OrderItem(
          id: orderId,
          totalAmount: orderData['totalAmount'],
          cartItems: (orderData['cartItems'] as List<dynamic>)
              .map((cart) => CartItem(
                    id: '',
                    title: cart['title'],
                    imageUrl: cart['imageUrl'],
                    price: cart['price'],
                    quantity: cart['quantity'],
                  ))
              .toList(),
          date: DateTime.parse(orderData['date']),
        );
        loadedOrders.add(order);
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(double totalAmount, List<CartItem> cartItems) async {
    try {
      final url =
          'https://shopapp-695d8.firebaseio.com/orders/$userId.json?auth=$token';
      final date = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'totalAmount': totalAmount,
          'date': date.toIso8601String(),
          'cartItems': cartItems
              .map((product) => {
                    'title': product.title,
                    'imageUrl': product.imageUrl,
                    'price': product.price,
                    'quantity': product.quantity,
                  })
              .toList(),
        }),
      );

      if (totalAmount != 0.0) {
        _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              totalAmount: totalAmount,
              cartItems: cartItems,
              date: date),
        );
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<CartItem> itemsInOrder(int index) {
    return _orders[index].cartItems;
  }
}
