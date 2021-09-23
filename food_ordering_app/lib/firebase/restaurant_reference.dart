import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/restaurant_model.dart';
import 'package:food_ordering_app/strings/main_strings.dart';

Future<List<RestaurantModel>> getRestaurantList() async{

  var list = List<RestaurantModel>.empty(growable: true );
  var source = await FirebaseDatabase.instance.reference().child(RESTAURENT_REF).once();
  Map<dynamic, dynamic> values = source.value;
  RestaurantModel? restaurantModel;
  values.forEach((key, value) {
    restaurantModel = RestaurantModel.fromJson(jsonDecode(jsonEncode(value)));
    restaurantModel!.restaurantId = key;
    list.add(restaurantModel!);
  });


  return list;
  
}