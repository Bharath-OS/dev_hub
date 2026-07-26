class UserEntity {
  final String id; // Firebase Auth UID
  final String githubId; // GitHub numeric ID
  final String githubUsername; // GitHub login handle
  final String displayName; // GitHub display name
  final String email; // GitHub primary email
  final DateTime createdAt; // account creation time
  final DateTime lastSeen; // last active time
  final String? avatarUrl; // GitHub profile picture
  final List<GitHubOrgInfo>? allOrganizations; // orgs with admin/owner access
  final List<GitHubOrgInfo>? ownOrganizations;
  final String? currentOrganizationId; // selected org ID
  final String? currentOrganizationLogin; // selected org login
  final SubscriptionInfo? subscription; // subscription state
  final String? fcmToken; // device push token
  final String? githubAccessToken; // GitHub OAuth access token

  UserEntity({
    required this.id,
    required this.githubId,
    required this.githubUsername,
    required this.displayName,
    required this.avatarUrl,
    required this.email,
    this.allOrganizations,
    this.ownOrganizations,
    this.currentOrganizationId,
    this.currentOrganizationLogin,
    required this.subscription,
    this.fcmToken,
    this.githubAccessToken,
    required this.createdAt,
    required this.lastSeen,
  });
}

class GitHubOrgInfo {
  final String id;
  final String login;
  final String avatarUrl;
  final String? role; // owner/admin/member
  final String? state;

  GitHubOrgInfo({
    required this.id,
    required this.login,
    required this.avatarUrl,
    this.role,
    this.state,
  });
}

class SubscriptionInfo {
  final String plan; // free/pro
  final String? razorpaySubscriptionId;
  final String? razorpayCustomerId;
  final String status; // active/cancelled/expired
  final DateTime? renewsAt;
  final DateTime? cancelledAt;

  SubscriptionInfo({
    required this.plan,
    this.razorpaySubscriptionId,
    this.razorpayCustomerId,
    required this.status,
    this.renewsAt,
    this.cancelledAt,
  });
}
