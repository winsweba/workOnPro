import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';

Future<List<CategoryModel>> getCategoryByRestaurantId(String restaurantId) async{

  var list = List<CategoryModel>.empty(growable: true );
  var source = await FirebaseDatabase.instance.reference()
  .child(RESTAURENT_REF)
  .child(restaurantId)
  .child(CATEGORY_REF)
  .once();
  Map<dynamic, dynamic> values = source.value;
  values.forEach((key, value) {
    list.add(CategoryModel.fromJson(jsonDecode(jsonEncode(value))));
  });


  return list;
  
}