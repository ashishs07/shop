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
