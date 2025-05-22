import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('You have reached the end of the Quiz')),
      body: Center(child: Text('You have reached the end of the Quiz')),
    );
  }
}
