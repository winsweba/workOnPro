import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/view_model/cart_vm/cart_view_model.dart';

class CartViewModelImp implements CartViewModel{
  void updateCart(CartStateController controller, int index, int value ) {
    controller.cart[index].quantity =
    value;
controller.cart.refresh();
  }
}