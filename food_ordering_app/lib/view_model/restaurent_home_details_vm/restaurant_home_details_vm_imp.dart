import 'package:food_ordering_app/firebase/best_deal_reference.dart';
import 'package:food_ordering_app/firebase/populer_reference.dart';
import 'package:food_ordering_app/firebase/restaurant_reference.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';
import 'package:food_ordering_app/view_model/restaurent_home_details_vm/restaurant_home_details_vm.dart';

class RestaurantHomeDetailViewModelImp implements RestaurantHomeDetailViewModel{
  @override
  Future<List<PopulerItemModel>> desplayMostPopulerByRestaurantId(String restaurantId) {
    return getMostPopulerByRestaurantId(restaurantId);
  }

  @override
  Future<List<PopulerItemModel>> desplayBestDealsByRestaurantId(String restaurantId) {
    return getBestDealByRestaurantId(restaurantId);
  }
  
}