import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CartInfo extends StatelessWidget {
   final CartModel cartModel;

   CartInfo({Key? key, required this.cartModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              cartModel.name,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.grey,
                    size: 16,
                  ),
                  Text(
                    '${currencyFormat.format(cartModel.price)}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
