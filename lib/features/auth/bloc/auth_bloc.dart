import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final List<String> signInIcons = [
    AppAssets.faceBook,
    AppAssets.google,
    AppAssets.apple
  ];

  AuthBloc() : super(const AuthState()) {
    on<HandleObscureTextChangeEvent>(_handleObscureTextChangeEvent);
    on<PasswordInputEvent>(_handlePasswordInputEvent);
  }

  /// Handles password visibility toggle event.
  FutureOr<void> _handleObscureTextChangeEvent(
    HandleObscureTextChangeEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isObscureText: !state.isObscureText));
  }

  /// Handles password input changes.
  FutureOr<void> _handlePasswordInputEvent(
    PasswordInputEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isObscureText: state.isObscureText));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    return super.close();
  }
}
