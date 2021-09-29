import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/sate/cart_state.dart';

class CartImageWidget extends StatelessWidget {
  final CartStateController controller;
  final CartModel cartModel;

  CartImageWidget({Key? key, required this.controller, required this.cartModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: cartModel.image,
      fit: BoxFit.cover,
      errorWidget: (context, url, err) => Center(
        child: Icon(Icons.image),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
