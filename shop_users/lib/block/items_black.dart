
import 'package:shop_users/model/added_cart_info_model.dart';
import 'package:shop_users/model/cart_item.dart';
import 'package:shop_users/servers/firestore_servers.dart';

class CartItemBlock{
  final db = FirestoreService();

  Stream<List<CartItem>> get fetchUpcomingProduct => db.fetchUpcomingProduct();

  Stream<List<AddedCartInfoModel>>  fetchUpcomingProductToCart(String userId) => db.fetchUpcomingProductToCart(userId);

  dispose(){
    
  }
}
// class CartItemBlocks{
//   final db = FirestoreService();

//   // Stream<List<CartItem>> get fetchUpcomingProduct => db.fetchUpcomingProduct();

//   Stream<List<AddedCartInfoModel>> get fetchUpcomingProductToCart/*(String userId) */=> db.fetchUpcomingProductToCart()/*(userId)*/;

//   dispose(){
    
//   }
// }