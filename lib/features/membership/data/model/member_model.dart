import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';

class MemberModel extends MemberEntity {
  MemberModel({
    required super.uid,
    required super.memberName,
    required super.memberEmail,
    required super.memberAvatarUrl,
    required super.role,
    required super.joinedAt,
    required super.githubUsername,
    required super.workspaceId,
    required super.invitedBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': super.uid,
      'workspace_id': super.workspaceId,
      'member_name': super.memberName,
      'login': super.githubUsername,
      'email': super.memberEmail,
      'avatar_url': super.memberAvatarUrl,
      'role': super.role,
      'joined_at': super.joinedAt.toIso8601String(),
      'invited_by': super.invitedBy,
    };
  }

  factory MemberModel.fromMap({
    required Map<String, dynamic> map,
    String workspaceId = '',
    String role = '',
    String invitedBy = '',
    DateTime? joinedAt,
  }) {
    return MemberModel(
      uid: map['id']?.toString() ?? '',
      memberName: (map['name'] ?? map['login'] ?? '') as String,
      memberEmail: (map['email'] ?? '') as String,
      memberAvatarUrl: (map['avatar_url'] ?? '') as String,
      role: role.isNotEmpty ? role : ((map['role'] ?? '') as String),
      joinedAt: joinedAt ?? DateTime.now(),
      githubUsername: (map['login'] ?? '') as String,
      workspaceId: (map['workspace_id'] ?? workspaceId) as String,
      invitedBy: (map['invited_by'] ?? invitedBy) as String,
    );
  }

  MemberModel copyWith({
    String? uid,
    String? workspaceId,
    String? memberName,
    String? githubUsername,
    String? memberAvatarUrl,
    String? memberEmail,
    String? role,
    String? invitedBy,
    DateTime? joinedAt,
  }) {
    return MemberModel(
      uid: uid ?? super.uid,
      role: role ?? super.role,
      invitedBy: invitedBy ?? super.invitedBy,
      joinedAt: joinedAt ?? super.joinedAt,
      workspaceId: workspaceId ?? super.workspaceId,
      memberName: memberName ?? super.memberName,
      memberEmail: memberEmail ?? super.memberEmail,
      memberAvatarUrl: memberAvatarUrl ?? super.memberAvatarUrl,
      githubUsername: githubUsername ?? super.githubUsername,
    );
  }
}
