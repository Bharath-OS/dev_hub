import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/params/firestore_params.dart';
import '../database_interface.dart';

class FirestoreService implements DatabaseInterface<FirestoreParams, dynamic> {
  late final FirebaseFirestore _firestore;

  FirestoreService(FirebaseFirestore firestore) : _firestore = firestore;

  @override
  Future<void> create(FirestoreParams params) async {
    try {
      if (params.id == null) {
        await _firestore
            .collection(params.collectionPath)
            .add(params.data!)
            .onError((e, _) => throw Exception(e.toString()));
        return;
      }
      await _firestore
          .collection(params.collectionPath)
          .doc(params.id)
          .set(params.data!)
          .onError((error, _) => Failure(error.toString()));
    } catch (error) {
      throw Failure(error.toString());
    }
  }

  @override
  Future<void> update(FirestoreParams params) async {
    await _firestore
        .collection(params.collectionPath)
        .doc(params.id)
        .update(params.data!);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
    FirestoreParams params,
  ) async {
    return await _firestore
        .collection(params.collectionPath)
        .doc(params.id)
        .get();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> readAll(FirestoreParams params) {
    CollectionReference<Map<String, dynamic>> collection =
        _firestore.collection(params.collectionPath);

    if (params.queryField != null && params.queryValue != null) {
      return collection
          .where(params.queryField!, isEqualTo: params.queryValue)
          .snapshots();
    }

    return collection.snapshots();
  }

  @override
  Future<void> delete(FirestoreParams params) async {
    await _firestore.collection(params.collectionPath).doc(params.id).delete();
  }
}

