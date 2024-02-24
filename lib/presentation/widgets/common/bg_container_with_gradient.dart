import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class BgContainerWithGradient extends StatelessWidget {
  const BgContainerWithGradient({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.blue.withOpacity(0.8),
              Colors.blue.withOpacity(0.6),
              constants.azurieshWhite1,
              constants.azurieshWhite1,
              constants.azurieshWhite2.withOpacity(0.5),
            ]),
      ),
      child: child,
    );
  }
}
