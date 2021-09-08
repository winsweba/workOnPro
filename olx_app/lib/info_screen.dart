import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("This is simple buying and selling App.", style: TextStyle(),),
            Text("Use your mobile money number for payment if you want upload a product,", style: TextStyle(),),
            Text("by Tap the pulls (+) button.", style: TextStyle(),),
            Text("Double Tap on image to get details and phone No. of the seller  ", style: TextStyle(),),
            Text("Double Tap on the delete icon to delete product", style: TextStyle(),),
            Text("Tap on the pen icon to edit product", style: TextStyle(),),
            Text("For o", style: TextStyle(),),
            Text("You can contact Adim at winsweba@gmail.com", style: TextStyle(),),
            Text("OR", style: TextStyle(),),
            Text("Call or What's App me at 0241012217", style: TextStyle(),),
          ],
        ),
      ),
    );
  }
}