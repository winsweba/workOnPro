import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/sate/place_order_state.dart';
import 'package:food_ordering_app/strings/place_order_string.dart';
import 'package:food_ordering_app/utils/const.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderScreen extends StatelessWidget {
  final placeOrderState = Get.put(PlaceOrderController());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final commentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(placeOrderText),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        validator: ValidationBuilder(
                                requiredMessage:
                                    '$firstNameText $isRequiredText')
                            .required()
                            .build(),
                        decoration: InputDecoration(
                          hintText: firstNameText,
                          label: Text(firstNameText),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        validator: ValidationBuilder(
                                requiredMessage:
                                    '$lastNameText $isRequiredText')
                            .required()
                            .build(),
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
                     TextFormField(
                        controller: addressController,
                        validator: ValidationBuilder(
                                requiredMessage:
                                    '$addressText $isRequiredText')
                            .required()
                            .build(),
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
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: commentController,
                        validator: ValidationBuilder(
                                requiredMessage:
                                    '$commentText $isRequiredText')
                            .required()
                            .build(),
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
                  child: ElevatedButton(
                       child: Text(placeOrderText),
                       onPressed: () {
                         if(formKey.currentState!.validate()){
                           print("Ok");
                         }
                       },
                       ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
