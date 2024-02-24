import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weather/presentation/constants/constants.dart';
import 'package:weather/presentation/screens/signup_screen.dart';

import 'common/custom_elevated_button.dart';
import 'common/custom_text_button.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  bool viewPassword = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    Constants constants = Constants();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Sign in Text
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: constants.cetaceanBlue,
          ),
        ),
        const SizedBox(height: 20),

        /// Email form field
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: emailTextController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            label: Text('Email'),
            prefixIcon: Icon(Iconsax.direct_right),
          ),
        ),
        const SizedBox(height: 15),

        /// Password form field
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: passwordTextController,
          obscureText: viewPassword ? false : true,
          decoration: InputDecoration(
            label: const Text('Password'),
            prefixIcon: const Icon(Iconsax.password_check),
            suffixIcon: IconButton(
              icon: Icon(viewPassword ? Iconsax.eye : Iconsax.eye_slash),
              onPressed: () {
                setState(() {
                  viewPassword = !viewPassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// Forgot password text button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            CustomTextButton(
              text: 'Forgot Password?',
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 60),

        /// Sign in button
        CustomElevatedButton(
          text: 'Sign in',
          onPressed: () {
            authBloc.add(AuthSigninRequested(
              email: emailTextController.text.trim(),
              password: passwordTextController.text.trim(),
            ));
          },
        ),
        const SizedBox(height: 10),

        /// Create account button
        Center(
          child: CustomTextButton(
            text: 'Don\'t have an account? Sign up.',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SignupScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          constants.slidingPageTransition(
                    context: context,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
