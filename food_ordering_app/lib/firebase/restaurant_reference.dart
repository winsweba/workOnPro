import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/restaurant_model.dart';
import 'package:food_ordering_app/strings/main_strings.dart';

Future<List<RestaurantModel>> getRestaurantList() async{

  var list = List<RestaurantModel>.empty(growable: true );
  var source = await FirebaseDatabase.instance.reference().child(RESTAURENT_REF).once();
  var values = source.snapshot;
  RestaurantModel? restaurantModel;
  values.children.forEach((element) {
    restaurantModel = RestaurantModel.fromJson(jsonDecode(jsonEncode(element.value)));
    restaurantModel!.restaurantId = element.key!;
    list.add(restaurantModel!);
  });


  return list;
  
}