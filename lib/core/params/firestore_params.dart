class FirestoreParams {
  final String collectionPath;
  final String? id;
  final Map<String, dynamic>? data;

  FirestoreParams({required this.collectionPath, this.id, this.data});
}