import 'package:food_ordering_app/firebase/category_reference.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/view_model/category_vm/category_viewmodel.dart';

class CategoryViewModelImp implements CategoryViewModel{
  @override
  Future<List<CategoryModel>> desplayCategoryByRestaurantId(String restaurantId) {
    return getCategoryByRestaurantId(restaurantId);
  }

}