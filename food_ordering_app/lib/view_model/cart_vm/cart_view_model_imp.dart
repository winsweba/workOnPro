import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/view_model/cart_vm/cart_view_model.dart';
import 'package:get/get.dart';

class CartViewModelImp implements CartViewModel {

  final MainStateController mainStateController = Get.find();
  
  void updateCart(CartStateController controller, int index, int value) {
    controller.cart[index].quantity = value;
    controller.cart.refresh();
    controller.saveDatabase();
  }

   void deleteCart(CartStateController controller, int index,){
     controller.cart.removeAt(index);
     controller.saveDatabase();

   }
   void clearCart(CartStateController controller,){
     controller.clearCart(mainStateController.selectedRestaurant.value.restaurantId);
   }
}
