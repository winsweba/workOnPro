import 'package:flutter/material.dart';
import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/strings/cart_strings.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:food_ordering_app/widget/cart/cart_total_item_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalWidget extends StatelessWidget {
  final CartStateController controller;

  TotalWidget({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TotalItemWidget(
              text: totalText,
              value: currencyFormat.format(controller.sumCart()) ,
              isSubTotal: false,
            ),
            Divider(thickness: 2,),
            TotalItemWidget(
              text: shippingFeeText,
              value: currencyFormat.format(controller.getShippingFee()) ,
              isSubTotal: false,
            ),
            Divider(thickness: 2,),
            TotalItemWidget(
              text: subTotalText,
              value: currencyFormat.format(controller.getSubTotal()) ,
              isSubTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

