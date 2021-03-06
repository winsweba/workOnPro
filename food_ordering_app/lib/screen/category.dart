import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/sate/category_state.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/view_model/category_vm/category_viewmodel_imp.dart';
import 'package:food_ordering_app/widget/category/category_list_widget.dart';
import 'package:food_ordering_app/widget/common/appbar_with_cart_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {

  final viewModel = CategoryViewModelImp();
  final MainStateController mainStateController = Get.find(); // cos we are on the main screen 
   final CategoryStateController categoryStateController = Get.put(CategoryStateController()); // 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCartButton(titel: '${mainStateController.selectedRestaurant.value.name}'),
      body: FutureBuilder(
        future: viewModel.desplayCategoryByRestaurantId(mainStateController.selectedRestaurant.value.restaurantId),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshort.data as List<CategoryModel>;
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: CategoryListWidget(lst: lst, categoryStateController: categoryStateController,),
            );
          }
        },
      ),
      
    );
  }
}