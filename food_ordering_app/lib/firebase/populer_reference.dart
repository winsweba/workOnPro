import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';

Future<List<PopulerItemModel>> getMostPopulerByRestaurantId(String restaurantId) async{

  var list = List<PopulerItemModel>.empty(growable: true );
  var source = await FirebaseDatabase.instance.ref()
  .child(RESTAURENT_REF)
  .child(restaurantId)
  .child(MOST_POPULAR_REFF)
  .once();
  var values = source.snapshot;
  values.children.forEach((element) {
    list.add(PopulerItemModel.fromJson(jsonDecode(jsonEncode(element.value))));
  });


  return list;
  
}