import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  String timeString = "";
  String dateString = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.green,
                ],
                begin: FractionalOffset(0.0,0.0),
                end: FractionalOffset(1.0,0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text("Admin Home Page", style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 3.0 ),),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text( timeString + "\n\n" + dateString,
                  style: TextStyle(fontSize: 30.0, color: Colors.white, letterSpacing: 3.0, fontWeight: FontWeight.bold ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.check_box, color: Colors.white ,),
                    label: Text( "Approve New Adds".toUpperCase(),
                    style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0,),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    // go to Approved adds page
                  },
                  ),

                  SizedBox(width: 50.0,),

                  ElevatedButton.icon(
                    icon: Icon(Icons.person_pin_sharp, color: Colors.white ,),
                    label: Text( "All Account".toUpperCase(),
                    style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0,),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    // go to All Account adds page
                  },
                  ),

                  SizedBox(width: 50.0,),
                ],
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.check_box, color: Colors.white ,),
                    label: Text( "Block Accout".toUpperCase(),
                    style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0,),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    // go to Block Account page
                  },
                  ),

                  SizedBox(width: 50.0,),

                  ElevatedButton.icon(
                    icon: Icon(Icons.person_pin_sharp, color: Colors.white ,),
                    label: Text( "Logout".toUpperCase(),
                    style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0,),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    // go to Logout adds page
                  },
                  ),

                  SizedBox(width: 50.0,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}