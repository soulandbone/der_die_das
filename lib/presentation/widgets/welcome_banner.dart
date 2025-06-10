import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: 300,
        color: Colors.amber,
        // padding: EdgeInsets.all(10),
        child: Text('Test'),
      ),
    );
  }
}
