part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent{}

final class AuthOrgVerification extends AuthEvent{
  final UserEntity user;
  AuthOrgVerification(this.user);
}
