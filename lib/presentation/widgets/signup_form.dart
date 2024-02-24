import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weather/presentation/constants/constants.dart';

import '../screens/signin_screen.dart';
import 'common/custom_elevated_button.dart';
import 'common/custom_text_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  var viewPassword = false;
  var viewConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    Constants constants = Constants();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Sign in Text
        Text(
          'Sign up',
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
          textInputAction: TextInputAction.next,
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
        const SizedBox(height: 15),

        /// Confirm password form field
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: confirmPasswordTextController,
          obscureText: viewConfirmPassword ? false : true,
          decoration: InputDecoration(
            label: const Text('Confirm Password'),
            prefixIcon: const Icon(Iconsax.password_check),
            suffixIcon: IconButton(
              icon: Icon(viewConfirmPassword ? Iconsax.eye : Iconsax.eye_slash),
              onPressed: () {
                setState(() {
                  viewConfirmPassword = !viewConfirmPassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 60),

        /// Sign up button
        CustomElevatedButton(
          text: 'Sign up',
          onPressed: () {
            authBloc.add(AuthSignupRequested(
              email: emailTextController.text.trim(),
              password: passwordTextController.text.trim(),
              confirmPassword: confirmPasswordTextController.text.trim(),
            ));
          },
        ),
        const SizedBox(height: 10),

        /// Already have account button
        Center(
          child: CustomTextButton(
            text: 'Already have an account? Sign in.',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SigninScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          constants.slidingPageTransition(
                    context: context,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
