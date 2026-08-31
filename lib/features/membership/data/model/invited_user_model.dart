import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';

/// User model for representation in search and selection
class InvitedUserModel extends InvitedUserEntity {
  InvitedUserModel({
    required super.inviteeId,
    required super.username,
    required super.fullName,
    required super.avatarUrl,
    super.role,
  });

  /// Factory constructor to parse GitHub Search API response or standard map
  factory InvitedUserModel.fromMap(Map<String, dynamic> map) {
    return InvitedUserModel(
      inviteeId: map['id'] ?? '',
      username: map['login'] ?? map['username'] ?? '',
      fullName: map['name'] ?? map['fullName'] ?? map['login'] ?? '',
      avatarUrl: map['avatar_url'] ?? map['avatarUrl'] ?? '',
    );
  }

  /// Converts [InvitedUserModel] instance into a Map structure
  Map<String, dynamic> toMap() {
    return {
      'id': inviteeId,
      'username': username,
      'fullName': fullName,
      'avatar_url': avatarUrl,
      'role': role,
    };
  }
}
