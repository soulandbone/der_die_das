import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({required this.icon, required this.titleText, super.key});

  final IconData icon;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Center(child: Text(titleText)));
  }
}
