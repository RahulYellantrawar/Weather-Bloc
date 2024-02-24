import 'package:flutter/material.dart';

class HomeScreenBg extends StatelessWidget {
  const HomeScreenBg({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.8),
              Colors.blue.withOpacity(0.7),
              Colors.blue.withOpacity(0.6),
              Colors.blue.withOpacity(0.5),
              Colors.blue.withOpacity(0.4),
              Colors.blue.withOpacity(0.3),
              Colors.blue.withOpacity(0.2),
            ]),
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
