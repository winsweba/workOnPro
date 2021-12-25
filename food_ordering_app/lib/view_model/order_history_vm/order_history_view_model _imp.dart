import 'package:food_ordering_app/firebase/order_reference.dart';
import 'package:food_ordering_app/models/order_models.dart';
import 'package:food_ordering_app/view_model/order_history_vm/order_history_view_model.dart';

class OrderHistoryViewModelImp implements OrderHistoryViewModel{
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId, String statusMode) {
    return getUserOrdersByRestaurant(restaurantId, statusMode);
  }

}