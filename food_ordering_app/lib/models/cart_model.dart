import 'package:food_ordering_app/models/food_model.dart';

class CartModel extends FoodModel {
  int quantity = 0;

  CartModel({
  
    id,
    name,
    price,
    image,
    addon,
    size,
   description,

  required this.quantity}):super(
    id:id,
    name:name,
    price:price,
    image:image,
    addon:addon,
    size:size,
   description:description,
  );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final food = FoodModel.fromJson(json);
    final quantity = json['quantity'];
    return CartModel(
      id:food.id,
    name:food.name,
    price:food.price,
    image:food.image,
    addon:food.addon,
    size:food.size,
   description:food.description,
   quantity: quantity,
    );
  }

  Map<String, dynamic> toJson(){
   var data = Map<String, dynamic>();
   data['name'] = this.name;
   data['price'] = this.price;
   data['id'] = this.id;
   data['image'] = this.image;
   data['description'] = this.description;
   data['size'] = this.size.map((v) => v.toJson()).toList();
   data['addon'] = this.addon.map((v) => v.toJson()).toList();
   data['quantity'] = this.quantity;

   return data;
  }


}