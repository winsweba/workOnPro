import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuWidgetCallback extends StatelessWidget {

  final String menuName;
  final Function (BuildContext context) callback;
  final IconData icon;

   MenuWidgetCallback({Key? key, required this.callback, required this.icon, required this.menuName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: callback(context), 
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: Colors.white ),
                  SizedBox(width: 30 ),
                  Text(menuName, style: GoogleFonts.jetBrainsMono(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),)
                ],
              ),
            ) ,
            );
  }
}