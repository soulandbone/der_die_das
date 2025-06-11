import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.black54]),
            ),
            // padding: EdgeInsets.all(10)
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Text(
            'Welcome User',
            style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 34)),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 40,
          child: Text('What do you want to do today?'),
        ),
      ],
    );
  }
}
