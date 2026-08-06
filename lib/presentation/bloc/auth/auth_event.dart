part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {}

final class AuthOrgVerification extends AuthEvent {
  final UserEntity user;
  AuthOrgVerification(this.user);
}

final class AuthCheckSession extends AuthEvent {}

final class AuthUpdateOrganization extends AuthEvent {
  final UserEntity user;
  final GitHubOrgInfo selectedOrg;
  AuthUpdateOrganization({required this.user, required this.selectedOrg});
}
