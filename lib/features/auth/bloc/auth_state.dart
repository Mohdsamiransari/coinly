part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final bool isObscureText;
  final RequestStatus isLoggingIn;
  final RequestStatus register;
  final bool isLoggedIn;

  const AuthState({
    this.isObscureText = true,
    this.isLoggingIn = const RequestStatus.idle(),
    this.isLoggedIn = false,
    this.register = const RequestStatus.idle(),
  });

  AuthState copyWith({
    bool? isObscureText,
    RequestStatus? isLoggingIn,
    bool? isLoggedIn,
    RequestStatus? register,
  }) {
    return AuthState(
      isObscureText: isObscureText ?? this.isObscureText,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      register: register ?? this.register,
    );
  }

  @override
  List<Object?> get props => [
        isObscureText,
        isLoggingIn,
        isLoggedIn,
        register,
      ];
}
