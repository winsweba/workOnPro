import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/order_models.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/main_strings.dart';
import 'package:food_ordering_app/view_model/order_history_vm/order_history_view_model%20_imp.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  final vm = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(orderHistoryText),
        ),
        body: FutureBuilder(
          future: vm.getUserHistory(
              mainStateController.selectedRestaurant.value.restaurantId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              var lst = snapshot.data as List<OrderModel>;
              return Center(
                child: Text('Your Order is ${lst.length}'),
              );
            }
          },
        ),
      ),
    );
  }
}
