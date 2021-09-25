import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/screen/menu.dart';
import 'package:food_ordering_app/screen/restaurant_home_details.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:food_ordering_app/widget/restaurant_home/best_deal_widget.dart';
import 'package:food_ordering_app/widget/restaurant_home/most_popular_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHome extends StatelessWidget {
  final drawerZoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ZoomDrawer(
          controller: drawerZoomController,
          menuScreen: MenuScreen(drawerZoomController),
           mainScreen: RestaurantHomeDetails(drawerZoomController),
           borderRadius: 24.0,
           showShadow: true,
           angle: 0.0,
           backgroundColor: Colors.grey[300]!,
           slideWidth: MediaQuery.of(context).size.width * 0.65,
           openCurve: Curves.bounceInOut,
           closeCurve: Curves.ease,
            ),
      ),
    );
  }
}
