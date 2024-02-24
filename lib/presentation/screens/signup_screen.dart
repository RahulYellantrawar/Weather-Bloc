import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weather/presentation/widgets/signup_form.dart';

import '../constants/constants.dart';
import '../widgets/common/bg_container_with_gradient.dart';
import '../widgets/common/logo_with_greeting.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// BlocConsumer to handle the auth states
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          /// If authentication failures, shows snackbar
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(Constants().customSnackBar(state.error));
          }

          /// If authentication success navigates to the HomeScreen
          if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const HomeScreen(pageIndex: 0)),
                (route) => false);
          }
        },
        builder: (context, state) {
          /// If authentication is in process, shows progress indicator
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const BgContainerWithGradient(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    /// App logo follwing with Greeting
                    LogoWithGreeting(greeting: 'Welcome \nto Weather'),
                    SizedBox(height: 60),

                    /// Sign up Form
                    SignupForm(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
