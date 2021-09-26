import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/size_model.dart';
import 'package:food_ordering_app/sate/food_detail_state.dart';
import 'package:food_ordering_app/sate/food_list_state.dart';
import 'package:food_ordering_app/strings/food_detail_string.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailSizeWidget extends StatelessWidget {
    final FoodListStateController foodListStateController;
    final FoodDetailStateController foodDetailStateController;

   FoodDetailSizeWidget({Key? key, required this.foodListStateController, required this.foodDetailStateController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return foodListStateController.selectedFood.value.size.length > 0
                  ? Card(
                      elevation: 12,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => ExpansionTile(
                              title: Text(
                                sizeText,
                                style: GoogleFonts.jetBrainsMono(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                              children: foodListStateController
                                  .selectedFood.value.size
                                  .map(
                                    (e) => RadioListTile<SizeModel>(
                                      title: Text(e.name),
                                        value: e,
                                        groupValue: foodDetailStateController
                                            .selectedSize.value,
                                        onChanged: (value) => foodDetailStateController.selectedSize.value = value! ),
                                  )
                                  .toList(),
                            ),),
                          ],
                        ),
                      ),
                    )
                  : Container();
  }
}