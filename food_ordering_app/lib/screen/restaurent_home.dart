import 'package:flutter/material.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:get/get.dart';

class RestaurantHome extends StatelessWidget {
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(title: Text("${mainStateController.selectedRestaurant.value.name }"),),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}