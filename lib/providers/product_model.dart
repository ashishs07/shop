import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavourite = false,
  });

  Future<void> changeFavouriteStatus(
      String productId, String userId, String token) async {
    final url =
        'https://shopapp-695d8.firebaseio.com/favData/$userId/$productId.json?auth=$token';
    await http.put(url,
        body: json.encode(
          !isFavourite,
        ));
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
