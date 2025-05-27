import 'package:flutter/material.dart';

class RowSummary extends StatelessWidget {
  const RowSummary({
    required this.text,
    required this.number,
    this.firstTextColor,
    this.secondTextColor,
    super.key,
  });

  final String text;
  final String number;
  final Color? firstTextColor;
  final Color? secondTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: firstTextColor),
        ),
        Text(
          number,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: secondTextColor,
          ),
        ),
      ],
    );
  }
}
