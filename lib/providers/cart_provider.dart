import 'package:flutter/material.dart';

import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get cartItemCount {
    return _cartItems.length;
  }

  List<CartItem> get cartItemsList {
    return [..._cartItems.values.toList()];
  }

  double get amount {
    double total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });

    return total;
  }

  int get totalQuantity {
    int total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.quantity;
    });

    return total;
  }

  void addToCart(
      {String productId, String title, double price, String imageUrl}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                imageUrl: existingCartItem.imageUrl,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              imageUrl: imageUrl,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }
}
