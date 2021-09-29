import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:food_ordering_app/sate/food_detail_state.dart';
import 'package:food_ordering_app/sate/food_list_state.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailNameWidget extends StatelessWidget {
  final FoodListStateController foodListStateController;
  final FoodDetailStateController foodDetailStateController;

  FoodDetailNameWidget(
      {Key? key,
      required this.foodListStateController,
      required this.foodDetailStateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${foodListStateController.selectedFood.value.name}',
              style: GoogleFonts.jetBrainsMono(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${foodListStateController.selectedFood.value.price}',
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                ),
                Obx(
                  () => ElegantNumberButton(
                    initialValue: foodDetailStateController.quantity.value,
                    minValue: 1,
                    maxValue: 100,
                    color: Colors.amber,
                    onChanged: (value) {
                      print('Clicked ${value}');
                      foodDetailStateController.quantity.value = value.toInt();
                    },
                    decimalPlaces: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
