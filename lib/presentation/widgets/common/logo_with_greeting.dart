import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class LogoWithGreeting extends StatelessWidget {
  final String greeting;

  const LogoWithGreeting({
    super.key,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Center(
      child: Column(
        children: [
          /// Logo
          Image.asset(
            'assets/images/logo.png',
            height: 150,
          ),

          /// Greeting
          Text(
            greeting,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: constants.azurieshWhite1,
            ),
          ),
        ],
      ),
    );
  }
}
