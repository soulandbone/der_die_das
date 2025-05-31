import 'package:flutter/material.dart';

class ToggleTile extends StatefulWidget {
  const ToggleTile({super.key});

  @override
  State<ToggleTile> createState() => _ToggleTileState();
}

class _ToggleTileState extends State<ToggleTile> {
  var isLightMode = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('Light mode', style: TextStyle(fontSize: 16)),
      trailing: Switch(
        value: isLightMode,
        onChanged: (value) {
          setState(() {
            isLightMode = !isLightMode;
          });
        },
      ),
    );
  }
}
