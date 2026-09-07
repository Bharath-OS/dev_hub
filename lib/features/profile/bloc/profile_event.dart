part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

final class EditUsernameEvent extends ProfileEvent {
  final String newUsername;
  const EditUsernameEvent(this.newUsername);
}
