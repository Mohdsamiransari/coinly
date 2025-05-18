part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final bool isObscureText;

  const AuthState({this.isObscureText = true});

  AuthState copyWith({bool? isObscureText}) {
    return AuthState(isObscureText: isObscureText ?? this.isObscureText);
  }

  @override
  List<Object?> get props => [isObscureText];
}
