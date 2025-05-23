import 'package:flutter/material.dart';

class RowSummary extends StatelessWidget {
  const RowSummary({required this.text, required this.number, super.key});

  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text(text), Text(number.toString())]);
  }
}
