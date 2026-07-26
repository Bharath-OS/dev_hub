import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/auth/auth_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  AuthBloc(this._authUseCase) : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final result = await _authUseCase.call(null);
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (accessToken) => emit(AuthSuccess(accessToken)),
      );
    });
  }
}
