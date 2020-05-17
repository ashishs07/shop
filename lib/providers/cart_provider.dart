import 'package:cloud_firestore/cloud_firestore.dart';
import './firestore_service.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import '../models/user.dart';

abstract class CartBase {
  Stream<List<CartItem>> getCartItems();
  Future<void> addToCart(Product product);
  Future<void> removeitem(String cartItemId);
}

class CartProvider implements CartBase {
  CartProvider(this.user);
  final User user;

  final _service = FirestoreService.instance;
  final _instance = Firestore.instance;

  Stream<List<CartItem>> getCartItems() => _service.collectionStream(
        path: 'users/${user.uid}/cart',
        builder: (snapshot) => CartItem(
          id: snapshot.documentID,
          title: snapshot.data['title'],
          imageUrl: snapshot.data['imageUrl'],
          quantity: int.parse(snapshot.data['quantity']),
          price: double.parse(snapshot.data['price']),
        ),
      );

  /*  Future<Map<String, dynamic>> getCartItemsData() async {
    double amount = 0;
    int quantity = 0;
    List<CartItem> cartItems = [];
    final snapshot =
        await _instance.collection('users/$uid/cart').getDocuments();
    final documents = snapshot.documents;

    documents.forEach((document) {
      cartItems.add(CartItem(
        id: document.documentID,
        title: document.data['title'],
        imageUrl: document.data['imageUrl'],
        quantity: int.parse(document.data['quantity']),
        price: double.parse(document.data['price']),
      ));
      quantity += int.parse(document.data['quantity']);
      amount += double.parse(document.data['price']) *
          int.parse(document.data['quantity']);
    });

    return {
      'amount': amount.toString(),
      'quantity': quantity.toString(),
      'list': cartItems,
    };
  } */

  Future<void> clearCart() async {
    final snapshot =
        await _instance.collection('users/${user.uid}/cart').getDocuments();
    final documents = snapshot.documents;

    documents.forEach((document) async => await _instance
        .collection('users/${user.uid}/cart')
        .document('${document.documentID}')
        .delete());
  }

  Future<void> addToCart(Product product) async {
    final documentRef = await _instance
        .collection('users/${user.uid}/cart')
        .document(product.id)
        .get();
    if (documentRef.exists) {
      var quantity = int.parse(documentRef.data['quantity']);
      quantity += 1;

      await _instance
          .collection('users/${user.uid}/cart')
          .document(product.id)
          .updateData({'quantity': quantity.toString()});
    } else {
      await _instance
          .collection('users/${user.uid}/cart')
          .document(product.id)
          .setData({
        'title': product.title,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'quantity': '1',
      });
    }
  }

  Future<void> removeitem(String cartItemId) async {
    await _instance
        .collection('users/${user.uid}/cart')
        .document(cartItemId)
        .delete();
  }
}
