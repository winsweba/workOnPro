import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/order_models.dart';
import 'package:get/get.dart';

class OrderHistoryState extends GetxController {
  var selectedOrder = new OrderModel(
          cartItemList: new List<CartModel>.empty(),
          comment: 'comment',
          createdDate: 0,
          discount: 0,
          finalPayment: 0,
          isCod: true,
          orderNumber: 'orderNumber',
          orderStatus: 0,
          shippingAddress: 'shippingAddress',
          shippingCost: 0,
          totalPayment: 0,
          userId: 'userId',
          userName: 'userName',
          userPhone: 'userPhone',
          restaurantId: 'restaurantId')
      .obs;
}
