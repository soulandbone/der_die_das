import 'package:der_die_das/presentation/widgets/optionMenuItem/clipper/my_clipper.dart';
import 'package:flutter/material.dart';

class OptionMenuItem extends StatelessWidget {
  const OptionMenuItem({required this.color, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Card(
        elevation: 2,
        child: Container(color: color, child: Center(child: Text('Test'))),
      ),
    );
  }
}
