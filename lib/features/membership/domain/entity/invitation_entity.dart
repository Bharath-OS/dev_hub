class InvitationEntity {
  final String uid;
  final int inviteeId;
  final String workspaceId;
  final String email;
  final String orgName;
  final String role;
  final String invitedBy;
  final DateTime sentAt;
  final String status; // 'pending', 'accepted', 'rejected'
  InvitationEntity({
    required this.email,
    required this.role,
    required this.invitedBy,
    required this.sentAt,
    required this.status,
    required this.uid,
    required this.workspaceId,
    required this.orgName,
    required this.inviteeId,
  });

  InvitationEntity copyWith({
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
    return InvitationEntity(
      email: email ?? this.email,
      role: role ?? this.role,
      invitedBy: invitedBy ?? this.invitedBy,
      sentAt: sentAt ?? this.sentAt,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      workspaceId: workspaceId ?? this.workspaceId,
      orgName: orgName ?? this.orgName,
      inviteeId: inviteeId ?? this.inviteeId,
    );
  }
}
