class InvitationEntity {
  final String email;
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
  });
}
