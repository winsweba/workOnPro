import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ApprovedAddsScreen extends StatefulWidget {

  @override
  _ApprovedAddsScreenState createState() => _ApprovedAddsScreenState();
}

class _ApprovedAddsScreenState extends State<ApprovedAddsScreen> {
  
  FirebaseAuth auth = FirebaseAuth.instance;
  String userName = "";
  String userNumber = "";
  String itemPrice = "";
  String itemModel = "";
  String itemColor = "";
  String description = "";
  String urlImage = "";
  String itemLocation = "";
  QuerySnapshot adds;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      FirebaseFirestore.instance.collection("items")
      .where("status", isEqualTo: "not approved")
      .get().then((result) {
        adds = result;
      });


    }

    Widget showAddsList() {
      if (adds != null ){

      }
      else{
        Center(
          child: Text("Loading"),
        );
      }
    }
  
  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.white,),
         onPressed: () {
           
         },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.refresh, color: Colors.white,),
              onPressed: () {

              },
            ),
          ),
        ],


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
          title: Text("Approve New Adds"),
          centerTitle: true,

      ),

      body: Center(
        child: Container(
          width: _screenWidth * 5,
          child: showAddsList(),
        ),
      ),
    );
  }
}