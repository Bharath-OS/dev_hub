abstract interface class DatabaseInterface<DataParams, ReturnDataType> {
  Future<void> create(DataParams params);

  Future<ReturnDataType> read(DataParams params);

  Future<void> update(DataParams params);

  Future<void> delete(DataParams params);

  ReturnDataType readAll(DataParams params);

}
