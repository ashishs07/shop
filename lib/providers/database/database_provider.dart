import './firestore_service.dart';
import './apiPath.dart';
import '../../models/product.dart';

abstract class DataBase {
  Stream<List<Product>> getProducts();
}

class DatabaseProvider implements DataBase {
  final _service = FirestoreService.instance;

  Stream<List<Product>> getProducts() => _service.collectionStream(
        path: APIPath.products(),
        builder: (snapshot) => Product(
          id: snapshot.documentID,
          title: snapshot.data['title'],
          description: snapshot.data['description'],
          imageUrl: snapshot.data['imageUrl'],
          price: snapshot.data['price'],
        ),
      );
}
