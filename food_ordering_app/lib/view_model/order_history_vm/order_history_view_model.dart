import 'package:food_ordering_app/models/order_models.dart';

abstract class OrderHistoryViewModel {
  Future<List<OrderModel>> getUserHistory(String restaurantId);
}