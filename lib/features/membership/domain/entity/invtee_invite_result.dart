class InviteeInviteResult {
  final String username;
  final bool success;
  final String? message; // failure reason, or preview text on success

  const InviteeInviteResult({
    required this.username,
    required this.success,
    this.message,
  });
}