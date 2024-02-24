part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

/// Auth initial state
final class AuthInitial extends AuthState {}

/// Auth success state
final class AuthSuccess extends AuthState {}

/// Auth checking state
final class AuthChecking extends AuthState {
  final bool isSignedin;
  AuthChecking({required this.isSignedin});
}

/// Auth failure state
final class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

/// Auth loading state
final class AuthLoading extends AuthState {}
