import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final _instance = Firestore.instance;

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = _instance.document(path);
    await reference.setData(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(DocumentSnapshot data),
    String orderBy,
  }) {
    Query reference;
    reference = _instance.collection(path);
    if (orderBy != null) {
      reference = _instance.collection(path).orderBy('date');
    }

    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((snapshot) => builder(snapshot)).toList());
  }
}
