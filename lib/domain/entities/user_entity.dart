class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String? profilePicUrl;
  final String accessToken;
  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePicUrl,
    required this.accessToken,
  });
}
