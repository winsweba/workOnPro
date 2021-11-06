import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/screen/place_order_screen.dart';
import 'package:food_ordering_app/view_model/cart_vm/cart_view_model.dart';
import 'package:food_ordering_app/view_model/main_vm/main_view_model_imp.dart';
import 'package:food_ordering_app/view_model/menu_vm/menu_viewmodel_imp.dart';
import 'package:get/get.dart';

class CartViewModelImp implements CartViewModel {

  final MainStateController mainStateController = Get.find();
  final MenuViewModelImp menuViewModelImp= new MenuViewModelImp();
  
  void updateCart(CartStateController controller,String  restaurantId ,int index, int value) {
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart[index].quantity = value;
    controller.cart.refresh();
    controller.saveDatabase();
  }

   void deleteCart(CartStateController controller, String  restaurantId,int index,){
     controller.cart.value = controller.getCart(restaurantId);
     controller.cart.removeAt(index);
     controller.saveDatabase();

   }
   void clearCart(CartStateController controller,){
     controller.clearCart(mainStateController.selectedRestaurant.value.restaurantId);
   }

  @override
  processCheckout(BuildContext context, List<CartModel> cart) {
    if(FirebaseAuth.instance.currentUser != null){
      Get.to(() => PlaceOrderScreen());
    }
    else {
      menuViewModelImp.login(context);
    }
  }
}
