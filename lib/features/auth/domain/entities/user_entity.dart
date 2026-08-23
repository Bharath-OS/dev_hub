class UserEntity {
  final String id; // Firebase Auth UID
  final int githubId; // GitHub numeric ID
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
  // final String? githubAccessToken; // GitHub OAuth access token

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
    // this.githubAccessToken,
    required this.createdAt,
    required this.lastSeen,
  });

  UserEntity copyWith({
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
    return UserEntity(
      id: id ?? this.id,
      githubId: githubId ?? this.githubId,
      githubUsername: githubUsername ?? this.githubUsername,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: this.createdAt,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      allOrganizations: allOrganizations ?? this.allOrganizations,
      ownOrganizations: ownOrganizations ?? this.ownOrganizations,
      currentOrganizationId: currentOrganizationId ?? this.currentOrganizationId,
      currentOrganizationLogin: currentOrganizationLogin ?? this.currentOrganizationLogin,
      subscription: subscription ?? this.subscription,
      fcmToken: fcmToken ?? this.fcmToken,
      // githubAccessToken: githubAccessToken ?? this.githubAccessToken,
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatarUrl': avatarUrl,
      'role': role,
      'state': state,
    };
  }

  factory GitHubOrgInfo.fromMap(Map<String, dynamic> map) {
    return GitHubOrgInfo(
      id: map['id']?.toString() ?? '',
      login: map['login'] as String,
      avatarUrl: map['avatarUrl'] as String? ?? map['avatar_url'] as String? ?? '',
      role: map['role'] as String?,
      state: map['state'] as String?,
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'plan': plan,
      'razorpaySubscriptionId': razorpaySubscriptionId,
      'razorpayCustomerId': razorpayCustomerId,
      'status': status,
      'renewsAt': renewsAt?.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
    };
  }

  factory SubscriptionInfo.fromMap(Map<String, dynamic> map) {
    return SubscriptionInfo(
      plan: map['plan'] as String,
      razorpaySubscriptionId: map['razorpaySubscriptionId'] as String?,
      razorpayCustomerId: map['razorpayCustomerId'] as String?,
      status: map['status'] as String,
      renewsAt: map['renewsAt'] != null
          ? DateTime.parse(map['renewsAt'] as String)
          : null,
      cancelledAt: map['cancelledAt'] != null
          ? DateTime.parse(map['cancelledAt'] as String)
          : null,
    );
  }
}
