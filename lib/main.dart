import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weather/bloc/search_bloc/search_bloc.dart';
import 'package:weather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather/presentation/constants/constants.dart';
import 'package:weather/presentation/screens/home_screen.dart';
import 'package:weather/presentation/screens/signin_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      /// Bloc Providers
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          inputDecorationTheme: Constants.inputDecorationTheme,
          fontFamily: 'Poppins',
        ),

        /// If authenticated HomeScreen else SigninScreen
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            context.read<AuthBloc>().add(Authenticated());
            if (state is AuthChecking) {
              if (state.isSignedin) {
                return const HomeScreen(pageIndex: 0);
              } else {
                return const SigninScreen();
              }
            }
            return const SigninScreen();
          },
        ),
      ),
    );
  }
}
