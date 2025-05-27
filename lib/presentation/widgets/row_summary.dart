import 'package:flutter/material.dart';

class RowSummary extends StatelessWidget {
  const RowSummary({required this.text, required this.number, super.key});

  final String text;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          number,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
