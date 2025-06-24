import 'package:der_die_das/presentation/widgets/mainMenu/ListWheel/listwheel_item.dart';
import 'package:flutter/material.dart';

class CustomMenuToggle extends StatelessWidget {
  const CustomMenuToggle({
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 50,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.black54),
            ),
          ),
          ListWheelScrollView.useDelegate(
            onSelectedItemChanged: onChanged,
            itemExtent: 75,
            physics: FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildListDelegate(
              children:
                  options
                      .map((e) => Center(child: ListwheelItem(text: (e))))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
