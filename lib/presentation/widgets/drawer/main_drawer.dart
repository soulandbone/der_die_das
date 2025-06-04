import 'package:der_die_das/presentation/widgets/drawer/toggle_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Der, Die, Das',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ),
          ToggleTile(),
          //DrawerTile(icon: Icons.abc, titleText: 'Abc'),
        ],
      ),
    );
  }
}
