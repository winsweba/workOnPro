import 'package:food_ordering_app/models/food_model.dart';
import 'package:get/get.dart';

class FoodListStateController extends GetxController{
  var selectedFood = FoodModel(description: 'description', id: 'id', name: 'name', price: 0, image: 'image', addon: [], size: []).obs;
}