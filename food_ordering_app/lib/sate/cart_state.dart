import 'dart:convert';

import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/food_model.dart';
import 'package:food_ordering_app/strings/cart_strings.dart';
import 'package:food_ordering_app/utils/const.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartStateController extends GetxController{
    var cart = List<CartModel>.empty(growable: true).obs;
    final box = GetStorage();

    addToCart( FoodModel foodModel ,{int quantity: 1}) async{
      try {
        var cartItem = CartModel(
          id: foodModel.id,
          name: foodModel.name,
          description: foodModel.description,
          image: foodModel.image,
          price: foodModel.price,
          addon: foodModel.addon,
          size: foodModel.size,
          quantity: quantity
        );

        if(isExists(cartItem)) {
          // if cart already day 
          var foodNeedToUpdate = cart.firstWhere((element) => element.id == cartItem.id);
          foodNeedToUpdate.quantity += quantity;
        }
        else {
          cart.add(cartItem);
        }
        // After update 
        var jsonDBEncode = jsonEncode(cart);
        await box.write(MY_CART_KEY, jsonDBEncode);
        cart.refresh();
        Get.snackbar(successTitle, successMessage);
      }catch (e) {
        Get.snackbar(errorTitle, e.toString());
      }


    }

  bool isExists(CartModel cartItem) {
    return cart.contains(cartItem);
  }

  sumCart(){
    return cart.length == 0 ? 0 : cart.map((e) => e.price*e.quantity )
    .reduce((value, element) => value + element);
  }

  getQuantity() {
    return cart.length == 0 ? 0 : cart.map((e) => e.quantity)
    .reduce((value, element) => value + element );
    
  }

  getShippingFee() => sumCart() * 0.1; /// 10% of total value

  getSubTotal() => sumCart() + getShippingFee();
}