import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/sate/place_order_state.dart';
import 'package:food_ordering_app/strings/place_order_string.dart';
import 'package:food_ordering_app/utils/const.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderScreen extends StatelessWidget {
  var placeOrderState = Get.put(PlaceOrderController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(placeOrderText),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: firstNameText,
                          label: Text(firstNameText),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: lastNameText,
                          label: Text(lastNameText),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: addressText,
                        label: Text(addressText),
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentText,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    RadioListTile<String>(
                      title: Text(codText),
                      value: COD_VAL,
                      groupValue: placeOrderState.paymentSlected.value,
                      onChanged: (String? val) {
                        placeOrderState.paymentSlected.value = val!;
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(brainTreeText),
                      value: BRAINTREE_VAL,
                      groupValue: placeOrderState.paymentSlected.value,
                      onChanged: (String? val) {
                        placeOrderState.paymentSlected.value = val!;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: commentText,
                        label: Text(addressText),
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: Text(placeOrderText)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
