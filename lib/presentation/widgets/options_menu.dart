import 'package:der_die_das/presentation/widgets/optionMenuItem/option_menu_item.dart';
import 'package:flutter/material.dart';

class OptionMenu extends StatelessWidget {
  const OptionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return OptionMenuItem(color: Colors.amber);
      },
    );
  }
}
