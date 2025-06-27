import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    required this.sliderValue,
    required this.onChanged,
    required this.isTimed,
    super.key,
  });

  final Function(double value) onChanged;
  final double sliderValue;
  final bool isTimed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(value: sliderValue, onChanged: onChanged, min: 10, max: 50),
        Text(
          isTimed
              ? '${sliderValue.toStringAsFixed(0)} secs '
              : '${sliderValue.toStringAsFixed(0)} questions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
