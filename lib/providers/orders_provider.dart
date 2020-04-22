import './database/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';

abstract class OrdersBase {}

class OrdersProvider implements OrdersBase {
  final _service = FirestoreService.instance;
  final _instance = Firestore.instance;

  Stream<List<OrderItem>> getOrders(String uid) => _service.collectionStream(
        path: 'users/$uid/orders',
        builder: (snapshot) => OrderItem(
          id: snapshot.documentID,
          totalAmount: snapshot.data['totalAmount'],
          cartItems: snapshot.data['cartItems'],
          date: DateTime.parse(snapshot.data['date']),
        ),
      );

  Stream<List<CartItem>> getOrderItems(String uid, String orderId) =>
      _service.collectionStream(
        path: 'users/$uid/orders/$orderId/items',
        builder: (snapshot) => CartItem(
          id: snapshot.documentID,
          title: snapshot.data['title'],
          imageUrl: snapshot.data['imageUrl'],
          quantity: snapshot.data['quantity'],
          price: snapshot.data['price'],
        ),
      );

  Future<void> placeOrder(
      String uid, Map<String, dynamic> data, List<CartItem> cartList) async {
    final reference = await _instance.collection('users/$uid/orders').add(data);
    cartList.forEach((item) async => await _instance
            .collection('users/$uid/orders/${reference.documentID}/items')
            .add({
          'title': item.title,
          'imageUrl': item.imageUrl,
          'price': item.price,
          'quantity': item.quantity,
        }));
  }
}

/* import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item.dart';
import '../models/order_item.dart';

class OrderProvider with ChangeNotifier {
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
 */
