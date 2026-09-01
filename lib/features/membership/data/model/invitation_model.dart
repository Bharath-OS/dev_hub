import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';

class InvitationModel extends InvitationEntity {
  InvitationModel({
    required super.email,
    required super.role,
    required super.invitedBy,
    required super.sentAt,
    required super.status,
    required super.uid,
    required super.workspaceId,
    required super.orgName,
    required super.inviteeId,
  });

  factory InvitationModel.fromMap({
    required Map<String, dynamic> map,
    String workspaceId = '',
    String orgName = '',
    int inviteeId = 0,
    String invitedBy = '',
  }) {
    final createdAt = map['created_at'];
    final inviter = map['inviter'];
    return InvitationModel(
      email: (map['email'] ?? map['login'] ?? '') as String,
      role: (map['role'] ?? '') as String,
      invitedBy: invitedBy.isNotEmpty
          ? invitedBy
          : (inviter is Map ? ((inviter['login'] ?? '') as String) : ''),
      sentAt: createdAt != null
          ? DateTime.parse(createdAt as String)
          : DateTime.now(),
      status: (map['invitation_status'] ?? 'pending') as String,
      uid: (map['uid'] ?? map['login'] ?? inviteeId.toString()) as String,
      workspaceId: (map['workspace_id'] ?? workspaceId) as String,
      orgName: (map['org_name'] ?? orgName) as String,
      inviteeId: (map['invitee_id'] as int?) ?? inviteeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'id': inviteeId,
      'workspace_id': workspaceId,
      'org_name': orgName,
      'email': email,
      'role': role,
      'invited_by': invitedBy,
      'created_at': sentAt.toIso8601String(),
      'invitation_status': status,
    };
  }

  InvitationModel copyWith({
    String? uid,
    int? inviteeId,
    String? workspaceId,
    String? email,
    String? orgName,
    String? role,
    String? invitedBy,
    DateTime? sentAt,
    String? status,
  }) {
    return InvitationModel(
      email: email ?? super.email,
      role: role ?? super.role,
      invitedBy: invitedBy ?? super.invitedBy,
      sentAt: sentAt ?? super.sentAt,
      status: status ?? super.status,
      uid: uid ?? super.uid,
      workspaceId: workspaceId ?? super.workspaceId,
      orgName: orgName ?? super.orgName,
      inviteeId: inviteeId ?? super.inviteeId,
    );
  }
}
