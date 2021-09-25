import 'package:food_ordering_app/models/category_model.dart';
import 'package:get/get.dart';

class CategoryStateController extends GetxController{
  var selectedCategory = CategoryModel(foods: [], image: 'image', name: 'name').obs;
}