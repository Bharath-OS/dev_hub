import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../../auth/domain/usecases/auth_usecases/auth_usecase.dart';
import '../../auth/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import '../../auth/domain/usecases/org_usecases/fetch_user_orgs_usecase.dart';
import '../../auth/domain/usecases/org_usecases/update_organization_usecase.dart';
import '../../../core/usecases/usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  final FetchUserOrgsUseCase _fetchUserOrgsUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UpdateOrganizationUseCase _updateOrganizationUseCase;

  AuthBloc(
    this._authUseCase,
    this._fetchUserOrgsUseCase,
    this._getCurrentUserUseCase,
    this._updateOrganizationUseCase,
  ) : super(AuthInitial()) {
    // ── GitHub OAuth login ────────────────────────────────────────────────────
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final result = await _authUseCase.call(null);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    // ── Org membership check after login ─────────────────────────────────────
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

    on<AuthCheckSession>((event, emit) async {
      emit(AuthSessionChecking());
      final result = await _getCurrentUserUseCase.call(NoParams());
      result.fold(
        (failure) {
          emit(AuthSessionNotFound());
        },
        (user) {
          if (user == null) {
            emit(AuthSessionNotFound());
          } else {
            emit(AuthSessionRestored(user));
          }
        },
      );
    });

    on<AuthUpdateOrganization>((event, emit) async {
      emit(AuthOrgUpdating());
      final result = await _updateOrganizationUseCase.call(
        UpdateOrgParams(user: event.user, selectedOrg: event.selectedOrg),
      );
      result.fold(
        (failure) => emit(AuthOrgUpdateFailure(failure.message)),
        (updatedUser) => emit(AuthOrgUpdateSuccess(updatedUser)),
      );
    });
  }
}
