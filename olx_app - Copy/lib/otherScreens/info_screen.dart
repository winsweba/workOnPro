import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only( top: 200.0),
        child: Center(
          child: Column(
            children: [
              Text("This is simple buying and selling App.", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("Use your mobile money number for \n payment if you want upload a product,", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("by Tap the pulls (+) button.", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("Double Tap on image to get details \n and phone No. of the seller  ", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("Double Tap on the delete icon to delete product", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("Tap on the pen icon to edit product", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("For o", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("You can contact Adim at winsweba@gmail.com", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("OR", style: TextStyle(fontFamily: "Lobster", fontSize: 17),),
              Text("Call or What's App me at 0241012217", style:TextStyle(fontFamily: "Lobster", fontSize: 17),),
            ],
          ),
        ),
      ),
    );
  }
}