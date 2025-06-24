import 'package:flutter/material.dart';

class ListwheelItem extends StatelessWidget {
  const ListwheelItem({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Card(
        child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
      ),
    );
  }
}
