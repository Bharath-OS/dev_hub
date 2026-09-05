abstract interface class AuthLocalDatabaseInterface {
  // Future<void> storeUserToken({required String userToken});
  // Future<String?> getToken();
  // Future<bool> isTokenContains();
  // Future<void> updateToken({required String accessToken});
  Future<dynamic> getData(String key);
  Future<void> setData({required String key, required dynamic value});
  Future<void> setIsAuthenticated(bool value);
  Future<bool> getIsAuthenticated();
  Future<void> setIsLoggedIn({required bool value});
  Future<bool> getIsLoggedIn();
}