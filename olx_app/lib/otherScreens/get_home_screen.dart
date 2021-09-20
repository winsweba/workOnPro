import 'package:flutter/material.dart';
import 'package:olx_app/otherScreens/home_screene.dart';

class GetHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
         padding: const EdgeInsets.only( top: 200.0),
        child: Center(
            child: Column(
              children: [
                Text("Product will be approved \nwithin 24 hours.", style: TextStyle(fontFamily: "Lobster", fontSize: 22),),
                Text("If not you can contact \n Adim at winsweba@gmail.com", style: TextStyle(fontFamily: "Lobster", fontSize: 22),),
                Text("OR", style: TextStyle(fontFamily: "Lobster", fontSize: 30),),
                Text("Call or What's App me at 0241012217", style: TextStyle(fontFamily: "Lobster", fontSize: 22),),
                SizedBox(height: 20,),

                GestureDetector(
                  onTap: () {
                    Route newRoute = MaterialPageRoute(builder: (context) => HomeScreene());
                    Navigator.push(context, newRoute);
                  },
                  child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20)),
                  child: Text(
                          "Go to home page",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}