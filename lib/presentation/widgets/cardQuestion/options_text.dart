import 'package:flutter/material.dart';

class OptionsText extends StatelessWidget {
  const OptionsText({required this.text, required this.textSize, super.key});

  final String text;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: textSize));
  }
}
