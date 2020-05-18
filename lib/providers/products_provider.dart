import './firestore_service.dart';
import '../models/product.dart';
import '../models/user.dart';

abstract class Products {
  Stream<List<Product>> getProducts();
}

class ProductsProvider implements Products {
  ProductsProvider(this.user);
  final User user;
  final _service = FirestoreService.instance;

  Future<void> addProduct(Product product) async {
    final data = {
      'creatorId': user.uid,
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
    };
    await _service.addData(collPath: 'products', data: data);
  }

  Future<void> updateProduct(Product product) async {
    final data = {
      'creatorId': user.uid,
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
    };

    await _service.setData(docPath: 'products/${product.id}', data: data);
  }

  Future<void> deleteProduct(String documentId) async =>
      await _service.deleteDocument(documentPath: 'products/$documentId');

  Stream<List<Product>> getProducts() => _service.collectionStream(
        path: 'products',
        builder: (snapshot) => Product(
          id: snapshot.documentID,
          title: snapshot.data['title'],
          description: snapshot.data['description'],
          imageUrl: snapshot.data['imageUrl'],
          price: snapshot.data['price'],
        ),
      );

  Stream<List<Product>> getUserProducts() => _service.collectionStreamWhere(
        path: 'products',
        field: 'creatorId',
        value: user.uid,
        builder: (snapshot) => Product(
          id: snapshot.documentID,
          title: snapshot.data['title'],
          description: snapshot.data['description'],
          imageUrl: snapshot.data['imageUrl'],
          price: snapshot.data['price'],
        ),
      );
}

/* import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_model.dart';

class ProductsProvider with ChangeNotifier {
  final String token;
  final String userId;

  ProductsProvider(this.token, this.userId, this._items);

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

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shopapp-695d8.firebaseio.com/products.json?auth=$token&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];
      url =
          'https://shopapp-695d8.firebaseio.com/favData/$userId.json?auth=$token';

      final favouriteResponse = await http.get(url);
      final favouriteData = json.decode(favouriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        final product = Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite:
              favouriteData == null ? false : favouriteData[prodId] ?? false,
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
          'creatorId': userId,
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
 */
