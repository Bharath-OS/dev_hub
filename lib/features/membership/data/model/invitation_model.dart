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

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      email: map['email'],
      role: map['role'],
      invitedBy: map['inviter']['login'],
      sentAt: DateTime.parse(map['created_at']),
      status: map['invitation_status'] ?? '',
      uid: map['uid'] ?? '',
      workspaceId: map['Workspace Id'],
      orgName: map['org_name'],
      inviteeId: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'id': inviteeId,
      'Workspace_id': workspaceId,
      'org_name': orgName,
      'email': email,
      'role': role,
      'inviter': invitedBy,
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
