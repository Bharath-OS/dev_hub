import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';

/// User model for representation in search and selection
class InvitedUserModel extends InvitedUserEntity {
  InvitedUserModel({
    required super.id,
    required super.username,
    required super.fullName,
    required super.avatarUrl,
    super.role = 'Developer',
  });

  /// Factory constructor to parse GitHub Search API response or standard map
  factory InvitedUserModel.fromMap(Map<String, dynamic> map) {
    return InvitedUserModel(
      id: map['id']?.toString() ?? '',
      username: map['login'] ?? map['username'] ?? '',
      fullName: map['name'] ?? map['fullName'] ?? map['login'] ?? '',
      avatarUrl: map['avatar_url'] ?? map['avatarUrl'] ?? '',
      // role: map['role'] ?? 'Developer',
    );
  }

  /// Converts [InvitedUserModel] instance into a Map structure
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': username,
      'fullName': fullName,
      'avatar_url': avatarUrl,
      'role': role,
    };
  }
}
