import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/restaurant_model.dart';
import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/screen/restaurent_home.dart';
import 'package:food_ordering_app/strings/main_strings.dart';
import 'package:food_ordering_app/view_model/main_vm/main_view_model_imp.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:food_ordering_app/widget/main/main_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp(
    app: app,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;

  const MyApp({required this.app});
  // MyApp({required this.app});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(app: app),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());
  final cartStetaController = Get.put(CartStateController());
  final box = GetStorage();


  MyHomePage({required this.app});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async{ 
      if(widget.box.hasData(MY_CART_KEY)){
        var cartSave = await widget.box.read(MY_CART_KEY) as String;
        if(cartSave.length   > 0  && cartSave.isNotEmpty ){
          final listCart = jsonDecode(cartSave) as List<dynamic>;
          final listCartParesed = listCart.map((e) => CartModel.fromJson(e) ).toList();

          if(listCartParesed.length > 0 ){
            widget.cartStetaController.cart.value = listCartParesed;
          }
        } 
      }
      else
        widget.cartStetaController.cart.value = new List<CartModel>.empty(growable: true); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurentText,
          style: GoogleFonts.jetBrainsMono(
              fontWeight: FontWeight.w900, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: FutureBuilder(
        future: widget.viewModel.displayRestaurantList(),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshort.data as List<RestaurantModel>;
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: LiveList(
                showItemDuration: Duration(milliseconds: 350),
                showItemInterval: Duration(milliseconds: 150),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: lst.length,
                itemBuilder: animationItemBuilder((index) => InkWell(
                      onTap: () {
                        widget.mainStateController.selectedRestaurant.value = lst[index];
                        Get.to(() => RestaurantHome());
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2.5 * 1.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RestaurantImageWidget(imageUrl: lst[index].imageUrl,),
                            RestaurantInfoWidget(name: lst[index].name, address: lst[index].address )
                          ],
                        ),
                      ),
                    ),),
              ),
            );
          }
        },
      ),
    );
  }
}

