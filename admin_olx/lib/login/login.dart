import 'package:admin_olx/login/backgroundPainter.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String email = "";
String password = "";

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        alignment: Alignment.lerp(
          Alignment.lerp(Alignment.centerRight, Alignment.center, 0.3),
          Alignment.topCenter,
          0.15,
        ),
        children: [
          CustomPaint(
            painter: BackgroundPainter(),
            child: Container(height: 900,),
          ),
          Center(
            child: Container(

            ),
          )
        ],
      ),
    );
  }
}