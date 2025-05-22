import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('You have reached the end of the Quiz')),
    );
  }
}
