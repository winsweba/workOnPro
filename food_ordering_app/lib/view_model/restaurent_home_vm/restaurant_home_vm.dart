import 'package:food_ordering_app/models/populer_item_model.dart';

abstract class RestaurantHomeViewModel{
  Future<List<PopulerItemModel>> desplayMostPopulerByRestaurantId(String restaurantId);

  Future<List<PopulerItemModel>> desplayBestDealsByRestaurantId(String restaurantId);
}