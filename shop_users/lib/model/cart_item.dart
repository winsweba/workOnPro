import 'package:meta/meta.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  
  final String imgUrl;
  final double price;
  final String description;

  const CartItem({
    @required this.imgUrl,
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.description,
  });
  factory CartItem.fromJson(Map<String, dynamic> json){
    return CartItem(
      id: json['id'].toString(),
      price: double.parse(json['price'].toString()),
      title: json['title'].toString(),
      imgUrl: json['imgUrl'].toString(),
      quantity: int.parse(json['quantity'].toString()),
      description: json['description'].toString(),
    );
  }
  CartItem.fromFirestore(Map<String,dynamic> firestore )
  : imgUrl = firestore['imgUrl'],
  title = firestore['title'],
  quantity = int.parse(firestore['quantity'].toString()),
  price = double.parse(firestore['price'].toString()),
  id = firestore['id'],
  description = firestore['description'];
}
