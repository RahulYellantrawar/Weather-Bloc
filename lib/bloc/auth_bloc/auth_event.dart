part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

/// Auth Signup event
final class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthSignupRequested({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

/// Auth signin event
final class AuthSigninRequested extends AuthEvent {
  final String email;
  final String password;
  AuthSigninRequested({required this.email, required this.password});
}

/// Authenticated or not
final class Authenticated extends AuthEvent {}

/// Auth signout event
final class AuthSignoutRequested extends AuthEvent {}
