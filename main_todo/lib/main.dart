import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_todo/app/modules/home/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Todo Demo',
      home:  HomePage(),
    );
  }
}
