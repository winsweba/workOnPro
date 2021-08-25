import 'dart:js';

import 'package:admin_olx/DialogBox/errorDialog.dart';
import 'package:admin_olx/DialogBox/loadingDialog.dart';
import 'package:admin_olx/MainScreen/home_screen.dart';
import 'package:admin_olx/login/backgroundPainter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}
    
class _LoginScreenState extends State<LoginScreen> {

  String email = "";
  String password = ""; 

  returnEmailFiled(IconData icon, bool isObscure){
    return TextField(
      onChanged: (value){
        email = value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 13.0, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)
        ),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(icon, color: Colors.green,)
      ),
    );
  }

  returnPasswordFiled(IconData icon, bool isObscure){
    return TextField(
      onChanged: (value){
        password = value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 13.0, color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)
        ),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(icon, color: Colors.green,)
      ),
    );
  }

  returnLongButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (email != "" && password != "")
        {
          // Login
          loginAdmin(context);
        }
      },
      child: Text("Login" , style: TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 2.0),),
    );
  }

  loginAdmin(BuildContext context) async{
    showDialog(
      context: context,
      builder: (context) {
        return LoadingAlertDialog(
          message: "Please wait.........",
        );
      }
    );

    User currentUser;

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((aAuth) {
      currentUser = aAuth.user;
    }).catchError((error) {
      Navigator.pop(context);

      showDialog(
      context: context,
      builder: (context) {
        return ErrorAlertDialog(
          message:"Error Occoured" + error.toString(),
        );
      }
    );

    });

    if (currentUser != null ){
      // Homepage
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen() );
      Navigator.pushReplacement(context, newRoute);
    }
    else {
      // Login page

      Route newRoute = MaterialPageRoute(builder: (context) => LoginScreen() );
      Navigator.pushReplacement(context, newRoute);
    }
  } 
  @override
  Widget build(BuildContext context) {
    
  double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        alignment: Alignment.lerp(
          Alignment.lerp(Alignment.centerLeft, Alignment.center, 0.3),
          Alignment.topCenter,
          0.15,
        ),
        children: [
          CustomPaint(
            painter: BackgroundPainter(),
            child: Container(height: _screenHeight,),
          ),
          Center(
            child: Container(
              width: _screenWidth * 5,
              child: Column(
                children: [
                  Center(
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Image.asset("images/admin.png", width: 300, height: 300,),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: returnEmailFiled(Icons.person, false),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: returnPasswordFiled(Icons.person, true),
                  ),
                  SizedBox(height: 40.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: returnLongButton(context),
                  ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      
    );
  }
}