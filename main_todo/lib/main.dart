import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:main_todo/app/data/services/storge/services.dart';
import 'package:main_todo/app/modules/home/binding.dart';
import 'package:main_todo/app/modules/home/view.dart';

void main() async{
 await GetStorage.init();
 await Get.putAsync(() => StorageService().init() );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Todo Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
