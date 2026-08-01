import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../../auth/domain/usecases/auth/auth_usecase.dart';
import '../../auth/domain/usecases/org/fetch_user_orgs_usecase.dart';
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
      print("[AuthBloc] AuthOrgVerification started for ${event.user.githubUsername}");
      final result = await _fetchUserOrgsUseCase.call(event.user);
      result.fold(
        (failure) {
          print("[AuthBloc] AuthOrgVerification FAILED: ${failure.message}");
          emit(AuthOrgError(failure.message, event.user));
        },
        (user) {
          final allOrgs = user.allOrganizations;
          final ownOrgs = user.ownOrganizations;
          print("[AuthBloc] allOrgs: ${allOrgs?.length ?? 0}, ownOrgs: ${ownOrgs?.length ?? 0}");

          if (allOrgs == null || allOrgs.isEmpty) {
            print("[AuthBloc] Emitting AuthNoOrganization");
            emit(AuthNoOrganization(user));
          } else if (ownOrgs != null && ownOrgs.isNotEmpty) {
            print("[AuthBloc] Emitting AuthOrgAdminSuccess");
            emit(AuthOrgAdminSuccess(user));
          } else {
            print("[AuthBloc] Emitting AuthMemberOnly");
            emit(AuthMemberOnly(user));
          }
        },
      );
    });
  }
}
