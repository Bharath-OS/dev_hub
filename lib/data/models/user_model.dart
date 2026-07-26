import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      createdAt: DateTime.now(),
      lastSeen: DateTime.now(),
    );
  }

  UserModel copyWith({
    String? id,
    String? githubId,
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
      fcmToken: fcmToken ?? super.fcmToken
    );
  }
}
