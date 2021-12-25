import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/order_models.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/main_strings.dart';
import 'package:food_ordering_app/utils/const.dart';
import 'package:food_ordering_app/view_model/order_history_vm/order_history_view_model%20_imp.dart';
import 'package:food_ordering_app/widget/order_history/order_history_list_widget.dart';
import 'package:food_ordering_app/widget/order_history/order_history_widget.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  final vm = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(orderHistoryText),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.cancel),),
              Tab(icon: Icon(Icons.refresh),),
              Tab(icon: Icon(Icons.check),),
            ],),
          ),
          body: TabBarView(children: [
            OrderHistoryWidget(vm: vm, mainStateController: mainStateController, orderStatusMode: ORDER_CANCELLED),
            OrderHistoryWidget(vm: vm, mainStateController: mainStateController, orderStatusMode: ORDER_PROCESSING),
            OrderHistoryWidget(vm: vm, mainStateController: mainStateController, orderStatusMode: ORDER_SHIPPED),
          ]),
        ),
      ),
    );
  }
}
