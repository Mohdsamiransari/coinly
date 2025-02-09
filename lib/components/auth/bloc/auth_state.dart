part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthActionState extends AuthState {}

final class HandleObscureTextChangeState extends AuthState {}
final class PasswordInputState extends AuthState {}
