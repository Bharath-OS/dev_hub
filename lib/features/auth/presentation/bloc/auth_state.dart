part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

abstract class AuthenticatedState extends AuthState{
  final UserEntity user;
  AuthenticatedState(this.user);
}
final class AuthSuccess extends AuthenticatedState {
  // final UserEntity user;
  AuthSuccess(super.user);
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}


final class AuthOrgVerifying extends AuthState {
  final UserEntity user;
  AuthOrgVerifying(this.user);
}

final class AuthOrgError extends AuthState {
  final String message;
  final UserEntity user;
  AuthOrgError(this.message, this.user);
}

final class AuthOrgSuccess extends AuthenticatedState {
  // final UserEntity user;
  AuthOrgSuccess(super.user);
}

final class AuthOrgAdminSuccess extends AuthenticatedState {
  // final UserEntity user;
  AuthOrgAdminSuccess(super.user);
}

final class AuthNoOrganization extends AuthState {
  final UserEntity user;
  AuthNoOrganization(this.user);
}

final class AuthMemberOnly extends AuthenticatedState {
  // final UserEntity user;
  AuthMemberOnly(super.user);
}

final class AuthSessionChecking extends AuthState {}

final class AuthSessionRestored extends AuthenticatedState {
  // final UserEntity user;
  AuthSessionRestored(super.user);
}

final class AuthSessionNotFound extends AuthState {}

final class AuthOrgUpdating extends AuthState {}

final class AuthOrgUpdateSuccess extends AuthenticatedState {
  // final UserEntity user;
  AuthOrgUpdateSuccess(super.user);
}

final class AuthOrgUpdateFailure extends AuthState {
  final String message;
  AuthOrgUpdateFailure(this.message);
}

final class AuthLogoutSuccess extends AuthState{
}
