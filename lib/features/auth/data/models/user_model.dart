import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.githubId,
    required super.githubUsername,
    required super.displayName,
    required super.email,
    required super.createdAt,
    required super.lastSeen,
    super.avatarUrl,
    super.allOrganizations,
    super.ownOrganizations,
    super.currentOrganizationId,
    super.currentOrganizationLogin,
    super.subscription,
    super.fcmToken,
    // super.githubAccessToken,
  });

  factory UserModel.fromRemoteSource(
      {required UserCredential credential}) {
    return UserModel(
      id: credential.user!.uid,
      githubId: credential.additionalUserInfo!.profile!['id'],
      githubUsername: credential.additionalUserInfo!.username!,
      displayName: credential.additionalUserInfo!.username!,
      avatarUrl: credential.user!.photoURL!,
      email: credential.user!.email!,
      // githubAccessToken: credential.credential?.accessToken,
      createdAt: DateTime.now(),
      lastSeen: DateTime.now(),
    );
  }
  @override
  UserModel copyWith({
    String? id,
    int? githubId,
    String? githubUsername,
    String? displayName,
    String? email,
    DateTime? lastSeen,
    String? avatarUrl,
    List<GitHubOrgInfo>? allOrganizations,
    List<GitHubOrgInfo>? ownOrganizations,
    String? currentOrganizationId,
    String? currentOrganizationLogin,
    SubscriptionInfo? subscription,
    String? fcmToken,
    // String? githubAccessToken,
  }) {
    return UserModel(
      id: id ?? super.id,
      githubId: githubId ?? super.githubId,
      githubUsername: githubUsername ?? super.githubUsername,
      displayName: displayName ?? super.displayName,
      email: email ?? super.email,
      createdAt: createdAt,
      lastSeen: lastSeen ?? super.lastSeen,
      avatarUrl: avatarUrl ?? super.avatarUrl,
      allOrganizations: allOrganizations ?? super.allOrganizations,
      ownOrganizations: ownOrganizations ?? super.ownOrganizations,
      currentOrganizationId: currentOrganizationId ?? super.currentOrganizationId,
      currentOrganizationLogin: currentOrganizationLogin ?? super.currentOrganizationLogin,
      subscription: subscription ?? super.subscription,
      fcmToken: fcmToken ?? super.fcmToken,
      // githubAccessToken: githubAccessToken ?? super.githubAccessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'githubId': githubId,
      'githubUsername': githubUsername,
      'displayName': displayName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'avatarUrl': avatarUrl,
      'allOrganizations': allOrganizations?.map((org) => org.toMap()).toList(),
      'ownOrganizations': ownOrganizations?.map((org) => org.toMap()).toList(),
      'currentOrganizationId': currentOrganizationId,
      'currentOrganizationLogin': currentOrganizationLogin,
      'subscription': subscription?.toMap(),
      'fcmToken': fcmToken,
      // 'githubAccessToken': githubAccessToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toString() ?? '',
      githubId: map['githubId'] is int ? map['githubId'] : (int.tryParse(map['githubId']?.toString() ?? '0') ?? 0),
      githubUsername: map['githubUsername'] ?? map['login'] ?? '',
      displayName: map['displayName'] ?? map['login'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'] as String) : DateTime.now(),
      lastSeen: map['lastSeen'] != null ? DateTime.parse(map['lastSeen'] as String) : DateTime.now(),
      avatarUrl: map['avatarUrl'] ?? map['avatar_url'],
      allOrganizations: (map['allOrganizations'] as List<dynamic>?)
          ?.map((org) => GitHubOrgInfo.fromMap(org as Map<String, dynamic>))
          .toList(),
      ownOrganizations: (map['ownOrganizations'] as List<dynamic>?)
          ?.map((org) => GitHubOrgInfo.fromMap(org as Map<String, dynamic>))
          .toList(),
      currentOrganizationId: map['currentOrganizationId']?.toString(),
      currentOrganizationLogin: map['currentOrganizationLogin']?.toString(),
      subscription: map['subscription'] != null
          ? SubscriptionInfo.fromMap(map['subscription'] as Map<String, dynamic>)
          : null,
      fcmToken: map['fcmToken'] as String?,
    );
  }
}
