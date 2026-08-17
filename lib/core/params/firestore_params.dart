class FirestoreParams {
  final String collectionPath;
  final String? id;
  final Map<String, dynamic>? data;
  final String? queryField;
  final dynamic queryValue;

  FirestoreParams({
    required this.collectionPath,
    this.id,
    this.data,
    this.queryField,
    this.queryValue,
  });
}