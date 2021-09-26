import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWithCartButton extends StatelessWidget implements PreferredSizeWidget {
 final String titel;

  const AppBarWithCartButton({Key? key, required this.titel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          "$titel",
          style: GoogleFonts.jetBrainsMono(color: Colors.black),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Badge(
            position: BadgePosition(top: 0, end: 1),
            animationDuration: Duration(milliseconds: 200),
            animationType: BadgeAnimationType.scale,
            showBadge: true,
            badgeColor: Colors.red,
            badgeContent: Text("0", style: GoogleFonts.jetBrainsMono(
              color: Colors.white
            ),
            ),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag) ),
          ),
          SizedBox(width: 20,)
        ],
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}