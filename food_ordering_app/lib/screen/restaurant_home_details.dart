import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/view_model/restaurent_home_details_vm/restaurant_home_details_vm.dart';
import 'package:food_ordering_app/view_model/restaurent_home_details_vm/restaurant_home_details_vm_imp.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:food_ordering_app/widget/restaurant_home/best_deal_widget.dart';
import 'package:food_ordering_app/widget/restaurant_home/most_popular_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHomeDetails extends StatelessWidget {

 final MainStateController mainStateController = Get.find();
  final RestaurantHomeDetailViewModel viewModel = RestaurantHomeDetailViewModelImp();
  final ZoomDrawerController zoomDrawerController;

   RestaurantHomeDetails( this.zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${mainStateController.selectedRestaurant.value.name}",
          style:  GoogleFonts.jetBrainsMono(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 10,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          leading: InkWell(child: Icon(Icons.view_headline),onTap: () => zoomDrawerController.toggle!() ,),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: MostPopularWidget(mainStateController: mainStateController, viewModel: viewModel,)
              ),
              Expanded(
                flex: 2,
                child: BestDealsWidget(viewModel: viewModel , mainStateController: mainStateController, )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
