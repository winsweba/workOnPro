import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_users/block/items_black.dart';
import 'package:shop_users/screens/Welcome/welcome_screen.dart';
import 'package:shop_users/screens/cart_page.dart';
import 'package:shop_users/screens/home_screen.dart';


final itemBlock = CartItemBlock();
// final itemBlocks = CartItemBlocks();

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => itemBlock ),
        // Provider(create: (context) => itemBlocks )
      ],
      child: SetUpApp(),
    );
  }

  @override
  void dispose() {
    itemBlock.dispose();
    // itemBlocks.dispose();
    super.dispose();
  }
}

class SetUpApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: (FirebaseAuth.instance.currentUser == null) ? WelcomeScreen() : HomePage(),
    );
  }
}