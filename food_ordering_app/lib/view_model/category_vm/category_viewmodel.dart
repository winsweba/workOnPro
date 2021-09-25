 import 'package:food_ordering_app/models/category_model.dart';

abstract class CategoryViewModel {
   Future<List<CategoryModel>> desplayCategoryByRestaurantId(String restaurantId);
 }