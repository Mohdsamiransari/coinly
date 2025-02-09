import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool obscureText = true;

  List<String> signInIcons = [
    AppAssets.faceBook,
    AppAssets.google,
    AppAssets.apple
  ];

  AuthBloc() : super(AuthInitial()) {
    on<HandleObscureTextChangeEvent>(_handleObscureTextChangeEvent);
    on<PasswordInputEvent>((event, emit){
      emit(PasswordInputState());
    });
  }

  FutureOr<void> _handleObscureTextChangeEvent(
      HandleObscureTextChangeEvent event, Emitter<AuthState> emit) {
    obscureText = !obscureText;

    emit(HandleObscureTextChangeState());
  }
}
