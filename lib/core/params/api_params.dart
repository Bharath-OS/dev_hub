class ApiParams {
  final String? accessToken;
  final String endpoint;
  final String? username;
  final String? orgName;
  final String? memberName;
  final Map<String, String>? queryParams;
  final Map<String, dynamic>? data;

  ApiParams({
    this.accessToken,
    required this.endpoint,
    this.username,
    this.data,
    this.queryParams,
    this.orgName,
    this.memberName,
  });
}
