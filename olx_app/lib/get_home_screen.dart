import 'package:flutter/material.dart';

class GetHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Text("Product will be approved within 24 hours.", style: TextStyle(),),
              Text("If not you can contact Adim at winsweba@gmail.com", style: TextStyle(),),
              Text("OR", style: TextStyle(),),
              Text("Call or What's App me at 0241012217", style: TextStyle(),),
              SizedBox(height: 20,),
              RaisedButton(
                    onPressed: () {

                    },
                    color: Colors.blue,
                    child: Text(
                      "Go to home page",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            ],
          ),
      ),
    );
  }
}