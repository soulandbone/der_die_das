import 'package:flutter/material.dart';

class MainMenuToggle extends StatefulWidget {
  const MainMenuToggle({required this.labels, super.key});

  final List<String> labels;

  @override
  State<MainMenuToggle> createState() => _MainMenuToggleState();
}

class _MainMenuToggleState extends State<MainMenuToggle> {
  late List<Widget> widgets = widget.labels.map((e) => Text(e)).toList();
  late List<bool> isSelected = List.generate(widgets.length, (index) {
    if (index == 0) {
      return true;
    } else {
      return false;
    }
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(15),
      fillColor: Colors.red,
      constraints: BoxConstraints(minHeight: 42, minWidth: 76),
      borderColor: Colors.blue,
      selectedColor: Colors.white,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < widgets.length; i++) {
            isSelected[i] = i == index;
          }
        });
      },
      isSelected: isSelected,
      children: widgets,
    );
  }
}
