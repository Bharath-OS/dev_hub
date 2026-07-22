import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/usecases/auth/auth_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  AuthBloc(this._authUseCase) : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final result = await _authUseCase.call(null);

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (accessToken) => emit(AuthSuccess(accessToken)),
      );
    });
  }
}
