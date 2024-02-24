import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weather/presentation/screens/search_screen.dart';

import '../screens/signin_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.location,
    required this.index,
  });

  final String location;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        /// Navigates to the Signin screen if the signout button clicked
        if (state is AuthInitial) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SigninScreen()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Signout button
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthSignoutRequested());
                  },
                  icon: const Icon(Iconsax.logout),
                ),

                /// Location name and page indicator
                Column(
                  children: [
                    /// Location
                    Text(
                      location,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),

                    /// Page indicator
                    Row(
                      children: [
                        Icon(
                          index == 0
                              ? Icons.fiber_manual_record_rounded
                              : Icons.fiber_manual_record_outlined,
                          size: 8,
                        ),
                        Icon(
                          index == 1
                              ? Icons.fiber_manual_record_rounded
                              : Icons.fiber_manual_record_outlined,
                          size: 8,
                        ),
                      ],
                    ),
                  ],
                ),

                /// Search button
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(Iconsax.search_normal_1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
