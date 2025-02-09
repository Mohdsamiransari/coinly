part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class HandleObscureTextChangeEvent extends AuthEvent {}

final class PasswordInputEvent extends AuthEvent {}
