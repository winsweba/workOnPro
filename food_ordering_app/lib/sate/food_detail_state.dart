import 'package:food_ordering_app/models/addon_model.dart';
import 'package:food_ordering_app/models/size_model.dart';
import 'package:get/get.dart';

class  FoodDetailStateController extends GetxController {
  var quntity = 1.obs;
  var selectedSize = SizeModel(name: "name", price: 0).obs;
  var selectedAddon = List<AddonModel>.empty(growable: true).obs;
}