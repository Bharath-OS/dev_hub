import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';
import 'package:dev_hub/features/profile/domain/params/user_params.dart';
import 'package:dev_hub/features/profile/domain/usecase/edit_user_details_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditUserDetailsUsecase _editUserDetailsUsecase;

  ProfileBloc({
    required EditUserDetailsUsecase editUserDetailsUsecase,
  }) : _editUserDetailsUsecase = editUserDetailsUsecase,
       super(ProfileInitial()) {
    on<EditUsernameEvent>((event, emit) async {
      emit(UsernameUpdating());
      try {
        final result = await _editUserDetailsUsecase.call(
          UserParams(userName: event.newUsername),
        );
        result.fold(
          (failure) => emit(ProfileFailure(failure.message)),
          (user) => emit(UsernameUpdated(user, event.newUsername)),
        );
      } catch (e) {
        emit(ProfileFailure(e.toString()));
      }
    });
  }
}
