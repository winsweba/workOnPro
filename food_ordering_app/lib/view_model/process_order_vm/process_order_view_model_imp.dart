
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/firebase/order_reference.dart';
import 'package:food_ordering_app/firebase/server_time_offset_reference.dart';
import 'package:food_ordering_app/models/order_models.dart';
import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:food_ordering_app/view_model/process_order_vm/process_order_view_model.dart';

class ProcessOrederViewModelImp extends ProcessOrederViewModel {
  @override
  Future<bool> submitOrder(OrderModel orderModel) {
    return writeOrderToFirebase(orderModel);
  }

  @override
  Future<OrderModel> createOrderModel(
      {required String restaurantId,
      required double discount,
      required String firstName,
      required String lastName,
      required String address,
      required String comment,
      required CartStateController cartStateController,
      required bool isCod}) async {
    var serverTime = await getServerTimeOffset();
    return new OrderModel(
        cartItemList: cartStateController.getCart(restaurantId),
        comment: comment,
        createdDate: serverTime,
        discount: discount,
        finalPayment: calculateFinalPayment(
            cartStateController.getSubTotal(restaurantId), discount),
        isCod: isCod,
        orderNumber: createOrderNumber(serverTime).toString(),
        orderStatus: 0,
        shippingAddress: address,
        shippingCost: cartStateController.getShippingFee(restaurantId),
        totalPayment: cartStateController.getSubTotal(restaurantId),
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: '$firstName $lastName',
        userPhone: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        restaurantId: restaurantId);
  }
}
