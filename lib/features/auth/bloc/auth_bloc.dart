import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/features/auth/data/repositories/auth_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String token = "";

  final List<String> signInIcons = [
    AppAssets.faceBook,
    AppAssets.google,
    AppAssets.apple
  ];

  AuthBloc() : super(AuthState()) {
    on<HandleObscureTextChangeEvent>(_handleObscureTextChangeEvent);
    on<PasswordInputEvent>(_handlePasswordInputEvent);
    on<AuthLoginEvent>(_authLoginEvent);
    on<AuthCheckLoggedIn>(_authCheckLoggedIn);
    on<AuthRegisterEvent>(_authRegisterEvent);
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

  FutureOr<void> _authLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoggingIn: const RequestStatus.loading()));
      final loginResponse = await AuthRepositories().logIn(data: {
        "email": emailController.text,
        "password": passwordController.text
      });
      if (loginResponse?.status == "success") {
        emit(state.copyWith(isLoggingIn: const RequestStatus.success()));
        return;
      }
      emit(state.copyWith(
          isLoggingIn: RequestStatus.error(loginResponse?.message ?? "")));
    } catch (e, stack) {
      log("Exception in _authLoginEvent: $e\n$stack");
      emit(state.copyWith(
          isLoggingIn: const RequestStatus.error("Internal Server Error")));
    }
  }

  FutureOr<void> _authCheckLoggedIn(
      AuthCheckLoggedIn event, Emitter<AuthState> emit) async {
    final preference = await SharedPreferences.getInstance();

    final isLoggedInToken = preference.getString("token");
    if (isLoggedInToken == null) {
      emit(state.copyWith(isLoggedIn: false));
      return;
    }
    token = isLoggedInToken;

    emit(state.copyWith(isLoggedIn: true));
  }

  FutureOr<void> _authRegisterEvent(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(register: const RequestStatus.loading()));

      final registerResponse = await AuthRepositories().register(data: {
        "email": emailController.text,
        "password": passwordController.text,
        "username": usernameController.text
      });
      if (registerResponse?.status == "success") {
        emit(state.copyWith(register: const RequestStatus.success()));
        return;
      }
      emit(state.copyWith(
          register: RequestStatus.error(registerResponse?.message ?? "")));
    } catch (e) {
      emit(state.copyWith(
          register: const RequestStatus.error("Internal Server Error")));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    return super.close();
  }
}
