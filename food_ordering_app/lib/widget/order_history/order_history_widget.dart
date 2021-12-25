import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/order_models.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/order_history_string.dart';
import 'package:food_ordering_app/view_model/order_history_vm/order_history_view_model%20_imp.dart';
import 'package:food_ordering_app/widget/order_history/order_history_list_widget.dart';

class OrderHistoryWidget extends StatelessWidget {
  final OrderHistoryViewModelImp vm;
  final MainStateController mainStateController;
  final String orderStatusMode;
  const OrderHistoryWidget({Key? key, required this.vm, required this.mainStateController, required this.orderStatusMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: vm.getUserHistory(
          mainStateController.selectedRestaurant.value.restaurantId, orderStatusMode ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var lst = snapshot.data as List<OrderModel>;
          if (lst.length == 0 )
            return Center(child: Text(emptyText),);
          return OrderHistoryListWidget(listOrder: lst);
        }
      },
    );
  }
}
