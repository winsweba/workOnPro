import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/view_model/restaurent_home_vm/restaurant_home_vm.dart';
import 'package:food_ordering_app/view_model/restaurent_home_vm/restaurant_home_vm_imp.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:food_ordering_app/widget/restaurant_home/best_deal_widget.dart';
import 'package:food_ordering_app/widget/restaurant_home/most_popular_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHome extends StatelessWidget {
  final MainStateController mainStateController = Get.find();
  final RestaurantHomeViewModel viewModel = RestaurantHomeViewModelImp();

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




// Container(
//                   child: FutureBuilder(
//                     future: viewModel.desplayBestDealsByRestaurantId(mainStateController.selectedRestaurant.value.restaurantId),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting )
//                         return Center (child: CircularProgressIndicator() );

//                       else {
//                         var lstBestDeal = snapshot.data as List<PopulerItemModel>;
//                         return CarouselSlider(
//                           items: lstBestDeal.map((e) => Builder(builder:  (BuildContext context ) {
//                             return Container(
//                               width: MediaQuery.of(context).size.width,
//                               margin: EdgeInsets.symmetric(horizontal: 5.0),
//                               child: Card(
//                                 semanticContainer: true,
//                                 clipBehavior: Clip.antiAliasWithSaveLayer,
//                                 child: Stack(
//                                   fit: StackFit.expand,
//                                   children: [
//                                     ImageFiltered(
//                                       imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5  ),
//                                       child:CachedNetworkImage(
//                                           imageUrl: e.image,
//                                           fit: BoxFit.cover,
//                                           errorWidget: (context, url, err) => Center(
//                                             child: Icon(Icons.image),
//                                           ),
//                                           progressIndicatorBuilder: (context, url, downloadProgress) => Center(
//                                             child: CircularProgressIndicator(),
//                                           ),
//                                         ),
//                                        ),

//                                        Center(
//                                          child: Text(
//                                            '${e.name}',
//                                            style: GoogleFonts.jetBrainsMono(
//                                              color: Colors.white,
//                                              fontSize: 16,
//                                            ),
//                                          )
//                                        )
//                                   ]
//                                 )
//                               ),
//                               );
//                           }, ),).toList(),
//                           options: CarouselOptions(
//                           autoPlay: true,
//                           autoPlayAnimationDuration: Duration(seconds: 3),
//                           autoPlayCurve: Curves.easeIn,
//                           height: double.infinity,
//                         ));
//                       }
//                     },
//                   ),
//                 ),