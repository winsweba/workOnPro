import 'package:food_ordering_app/models/order_models.dart';
import 'package:food_ordering_app/sate/cart_state.dart';

abstract class ProcessOrederViewModel {
  Future<bool> submitOrder(OrderModel orderModel);
  Future<OrderModel> createOrderModel(
      {required String restaurantId,
      required double discount,
      required String firstName,
      required String lastName,
      required String address,
      required String comment,
      required CartStateController cartStateController,
      required bool isCod});
}
