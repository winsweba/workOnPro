import 'package:food_ordering_app/sate/cart_state.dart';

abstract class CartViewModel{
  void updateCart(CartStateController controller, String  restaurantId,int index, int value ); 
  void deleteCart(CartStateController controller,String  restaurantId ,int index,);
  void clearCart(CartStateController controller,);
}