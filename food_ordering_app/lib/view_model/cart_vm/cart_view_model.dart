import 'package:food_ordering_app/sate/cart_state.dart';

abstract class CartViewModel{
  void updateCart(CartStateController controller, int index, int value ); 
  void deleteCart(CartStateController controller, int index,);
  void clearCart(CartStateController controller,);
}