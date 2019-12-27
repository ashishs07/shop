import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_model.dart';

class ProductsProvider with ChangeNotifier {
  final String token;

  ProductsProvider(this.token, this._items);

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProducts() async {
    final url =
        'https://shopapp-695d8.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        final product = Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite: prodData['isFavourite'],
        );
        loadedProducts.add(product);
        _items = loadedProducts;
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shopapp-695d8.firebaseio.com/products.json?auth=$token';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      _items.insert(0, newProduct);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String productId, Product product) async {
    final index = _items.indexWhere((prod) => prod.id == productId);
    if (index >= 0) {
      final url =
          'https://shopapp-695d8.firebaseio.com/products/$productId.json?auth=$token';
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }),
        );

        _items[index] = product;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteProduct(String productId) async {
    final productIndex = _items.indexWhere((prod) => prod.id == productId);
    final url =
        'https://shopapp-695d8.firebaseio.com/products/$productId.json?auth=$token';
    http.delete(url);
    _items.removeAt(productIndex);
    notifyListeners();
  }
}
