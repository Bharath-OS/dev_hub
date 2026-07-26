import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/auth/auth_usecase.dart';
import '../../../domain/usecases/org/fetch_user_orgs_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  final FetchUserOrgsUseCase _fetchUserOrgsUseCase;

  AuthBloc(this._authUseCase, this._fetchUserOrgsUseCase) : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final result = await _authUseCase.call(null);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    on<AuthOrgVerification>((event, emit) async {
      emit(AuthOrgVerifying(event.user));
      final result = await _fetchUserOrgsUseCase.call(event.user);
      result.fold(
        (failure) => emit(AuthOrgError(failure.message, event.user)),
        (user) {
          final allOrgs = user.allOrganizations;
          final ownOrgs = user.ownOrganizations;

          if (allOrgs == null || allOrgs.isEmpty) {
            emit(AuthNoOrganization(user));
          } else if (ownOrgs != null && ownOrgs.isNotEmpty) {
            emit(AuthOrgAdminSuccess(user));
          } else {
            emit(AuthMemberOnly(user));
          }
        },
      );
    });
  }
}
