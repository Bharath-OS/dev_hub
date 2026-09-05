class FirestoreParams {
  final String collectionPath;
  final String? id;
  final Map<String, dynamic>? data;
  final String? queryField;
  final dynamic queryValue;
  final String? arrayContainsField;
  final dynamic arrayContainsValue;

  FirestoreParams({
    required this.collectionPath,
    this.id,
    this.data,
    this.queryField,
    this.queryValue,
    this.arrayContainsField,
    this.arrayContainsValue,
  });
}