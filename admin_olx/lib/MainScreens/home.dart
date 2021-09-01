import 'dart:async';
import 'package:admin_olx/Login/login.dart';
import 'package:admin_olx/MainScreens/activateAccount.dart';
import 'package:admin_olx/MainScreens/approveAds.dart';
import 'package:admin_olx/MainScreens/blockedAccount.dart';
import 'package:admin_olx/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
{
  String timeString = "";
  String dateString = "";

  String formatDate(DateTime dateTime)
  {
    return DateFormat("dd MMMM, yyyy").format(dateTime);
  }

  String formatTime(DateTime dateTime)
  {
    return DateFormat("hh:mm:ss a").format(dateTime);
  }

  getTime()
  {
    final DateTime now = DateTime.now();
    final String formattedTime = formatTime(now);
    final String formattedDate = formatDate(now);

    if(this.mounted)
    {
      setState(() {
        timeString = formattedTime;
        dateString = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection("items")
        .where("status", isEqualTo: "not approved")
        .get().then((results)
    {
      ads = results;
    });

    dateString = formatDate(DateTime.now());
    timeString = formatTime(DateTime.now());

    Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                [
                  Colors.deepPurple,
                  Colors.green,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
              "Admin  Home  Page",
              style: TextStyle(fontSize: 20.0, color: Colors.white, letterSpacing: 3.0),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  timeString + "\n\n" + dateString,
                  style: TextStyle(fontSize: 30.0, color: Colors.white, letterSpacing: 3.0, fontWeight: FontWeight.bold),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton.icon(
                    icon: Icon(Icons.check_box, color: Colors.white,),
                    label: Text(
                      "Approve  New  Ads".toUpperCase(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: ()
                    {
                      //go to approve ads page
                      Route newRoute = MaterialPageRoute(builder: (_) => ApproveAdsScreen());
                      Navigator.pushReplacement(context, newRoute);
                    },
                  ),
                  SizedBox(width: 50.0,),

                  ElevatedButton.icon(
                    icon: Icon(Icons.person_add, color: Colors.white,),
                    label: Text(
                      "Activate an Accounts".toUpperCase(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: ()
                    {
                      //go to approve all accounts page
                      Route newRoute = MaterialPageRoute(builder: (_) => ActivateAccountsScreen());
                      Navigator.pushReplacement(context, newRoute);
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ElevatedButton.icon(
                    icon: Icon(Icons.block_flipped, color: Colors.white,),
                    label: Text(
                      "Block an Account".toUpperCase(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: ()
                    {
                      //go to blocked accounts page
                      Route newRoute = MaterialPageRoute(builder: (_) => BlockedAccountsScreen());
                      Navigator.pushReplacement(context, newRoute);
                    },
                  ),
                  SizedBox(width: 50.0,),

                  ElevatedButton.icon(
                    icon: Icon(Icons.logout, color: Colors.white,),
                    label: Text(
                      "Logout".toUpperCase(),
                      style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 3.0),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: ()
                    {
                      //logout admin
                      FirebaseAuth.instance.signOut().then((value)
                      {
                        Route newRoute = MaterialPageRoute(builder: (_) => LoginScreen());
                        Navigator.pushReplacement(context, newRoute);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
