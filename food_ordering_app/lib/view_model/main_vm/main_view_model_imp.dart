import 'package:food_ordering_app/firebase/restaurant_reference.dart';
import 'package:food_ordering_app/models/restaurant_model.dart';
import 'package:food_ordering_app/view_model/main_vm/main_view_model.dart';

class MainViewModelImp implements MainViewModel{
  @override
  Future<List<RestaurantModel>> displayRestaurantList() {

    return getRestaurantList();
  }

}