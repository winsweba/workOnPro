import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_users/strings/main_strings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp(app: app,));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;

  const MyApp({this.app});
  // MyApp({required this.app});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(app: app),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseApp app;

  const MyHomePage({this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurentText, style: GoogleFonts.josefinSans(fontWeight: FontWeight.w900, color: Colors.black),),
      backgroundColor: Colors.white,
      elevation: 10,
      ),
      body: Container(),
      
    );
  }
}
