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

  Future<void> clearCart() async {
    final snapshot =
        await _service.getDocuments(collectionPath: 'users/${user.uid}/cart');
    final documents = snapshot.documents;

    documents.forEach((document) async => await _service.deleteDocument(
        documentPath: 'users/${user.uid}/cart/${document.documentID}'));
  }

  Future<void> addToCart(Product product) async {
    final documentRef =
        await _service.getData(docPath: 'users/${user.uid}/cart/${product.id}');

    if (documentRef.exists) {
      var quantity = int.parse(documentRef.data['quantity']);
      quantity += 1;
      await _service.updateData(
          docPath: 'users/${user.uid}/cart/${product.id}',
          data: {'quantity': quantity.toString()});
    } else {
      await _service
          .setData(docPath: 'users/${user.uid}/cart/${product.id}', data: {
        'title': product.title,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'quantity': '1',
      });
    }
  }

  Future<void> removeitem(String cartItemId) async {
    await _service.deleteDocument(
        documentPath: 'users/${user.uid}/cart/$cartItemId');
  }
}
