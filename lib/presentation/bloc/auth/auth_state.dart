part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
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

final class AuthOrgSuccess extends AuthState {
  final UserEntity user;
  AuthOrgSuccess(this.user);
}

final class AuthOrgAdminSuccess extends AuthState {
  final UserEntity user;
  AuthOrgAdminSuccess(this.user);
}

final class AuthNoOrganization extends AuthState {
  final UserEntity user;
  AuthNoOrganization(this.user);
}

final class AuthMemberOnly extends AuthState {
  final UserEntity user;
  AuthMemberOnly(this.user);
}

final class AuthSessionChecking extends AuthState {}

final class AuthSessionRestored extends AuthState {
  final UserEntity user;
  AuthSessionRestored(this.user);
}

final class AuthSessionNotFound extends AuthState {}

final class AuthOrgUpdating extends AuthState {}

final class AuthOrgUpdateSuccess extends AuthState {
  final UserEntity user;
  AuthOrgUpdateSuccess(this.user);
}

final class AuthOrgUpdateFailure extends AuthState {
  final String message;
  AuthOrgUpdateFailure(this.message);
}
