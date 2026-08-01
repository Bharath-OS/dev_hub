abstract interface class LocalDatabase {
  Future<void> save(String key, dynamic value);

  Future<String?> readData(String key);

  Future<bool> isContains(String key);

  Future<void> delete(String key);

  Future<void> clearAll();
}