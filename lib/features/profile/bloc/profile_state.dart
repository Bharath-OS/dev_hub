part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class UsernameUpdating extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class UsernameUpdated extends ProfileState {
  final UserEntity user;
  final String newUsername;
  const UsernameUpdated(this.user, this.newUsername);

  @override
  List<Object?> get props => [user, newUsername];
}

final class ProfileFailure extends ProfileState {
  final String error;
  const ProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
