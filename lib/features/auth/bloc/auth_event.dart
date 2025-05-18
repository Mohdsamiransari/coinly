part of 'auth_bloc.dart';

/// Base class for all authentication events.
///
/// This sealed class represents all possible events that can occur
/// during the authentication process.
@immutable
sealed class AuthEvent {}

/// Event triggered when the password visibility needs to be toggled.
final class HandleObscureTextChangeEvent extends AuthEvent {}

/// Event triggered when password input changes.
final class PasswordInputEvent extends AuthEvent {}
