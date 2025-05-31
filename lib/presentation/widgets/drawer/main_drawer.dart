import 'package:der_die_das/presentation/widgets/drawer/drawer_tile.dart';
import 'package:der_die_das/presentation/widgets/drawer/toggle_tile.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Text('Der, Die, Das')),
          ToggleTile(),
          DrawerTile(icon: Icons.abc, titleText: 'Abc'),
        ],
      ),
    );
  }
}
