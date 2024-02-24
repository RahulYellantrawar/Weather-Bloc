import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignupRequested>(_onAuthSignupRequested);

    on<AuthSigninRequested>(_onAuthSigninRequested);

    on<Authenticated>(_onAuthCheck);

    on<AuthSignoutRequested>(_onAuthSignoutRequested);
  }

  /// On auth signup requested method
  void _onAuthSignupRequested(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;
      final confirmPassword = event.confirmPassword;

      /// Check the user input details
      if (email.length < 6) {
        return emit(AuthFailure("Enter valid email"));
      }
      if (password.length < 6) {
        return emit(AuthFailure("Password cannot be less than 6 characters"));
      }
      if (password != confirmPassword) {
        return emit(
            AuthFailure("Password and confirm password are not matching"));
      }

      /// Create User with email and password
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);

        /// Saving auth details on signig up
        final SharedPreferences s = await SharedPreferences.getInstance();
        s.setBool('signed_in', true);

        return emit(AuthSuccess());
      } on FirebaseAuthException catch (e) {
        /// Signup auth exceptions
        if (e.code == 'weak-password') {
          return emit(AuthFailure("The password provided is too weak."));
        } else if (e.code == 'email-already-in-use') {
          return emit(
              AuthFailure("The account already exists for that email."));
        }
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  /// On auth signin requested method
  void _onAuthSigninRequested(
    AuthSigninRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;

      /// Check email and password details
      if (email.length < 6) {
        return emit(AuthFailure("Email valid email"));
      }
      if (password.length < 6) {
        return emit(AuthFailure("Password cannot be less than 6 characters"));
      }

      /// Signing in with email and password
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        final SharedPreferences s = await SharedPreferences.getInstance();
        s.setBool('signed_in', true);

        return emit(AuthSuccess());
      } on FirebaseAuthException catch (e) {
        /// Signin auth exceptions
        if (e.code == 'user-not-found') {
          return emit(AuthFailure("No user found for that email."));
        } else if (e.code == 'wrong-password') {
          return emit(AuthFailure("Wrong password provided for that user."));
        } else {
          return emit(AuthFailure(e.code.toString()));
        }
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  /// On auth check method
  void _onAuthCheck(
    Authenticated event,
    Emitter<AuthState> emit,
  ) async {
    final SharedPreferences s = await SharedPreferences.getInstance();

    /// Get authentication details from the device
    final isSignedin = s.getBool('signed_in') ?? false;

    return emit(AuthChecking(isSignedin: isSignedin));
  }

  /// On auth signout requested method
  void _onAuthSignoutRequested(
    AuthSignoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();

      /// Saving auth details on device
      final SharedPreferences s = await SharedPreferences.getInstance();
      s.setBool('signed_in', false);

      return emit(AuthInitial());
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }
}
