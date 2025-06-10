import 'package:der_die_das/presentation/widgets/options_menu.dart';
import 'package:der_die_das/presentation/widgets/welcome_banner.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Der,Die,Das')),
      body: Column(children: [WelcomeBanner(), Expanded(child: OptionMenu())]),
    );
  }
}
