import './database/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_item.dart';
import '../models/cart_item.dart';

abstract class OrdersBase {}

class OrdersProvider implements OrdersBase {
  OrdersProvider(this.uid);
  final String uid;

  final _service = FirestoreService.instance;
  final _instance = Firestore.instance;

  Stream<List<OrderItem>> getOrders() => _service.collectionStream(
        path: 'users/$uid/orders',
        builder: (snapshot) => OrderItem(
          id: snapshot.documentID,
          totalAmount: snapshot.data['totalAmount'],
          cartItems: snapshot.data['cartItems'],
          date: DateTime.parse(snapshot.data['date']),
        ),
      );

  Stream<List<CartItem>> getOrderItems(String orderId) =>
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
      Map<String, dynamic> data, List<CartItem> cartList) async {
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
