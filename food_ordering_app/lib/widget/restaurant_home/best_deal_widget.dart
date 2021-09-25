import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/view_model/restaurent_home_details_vm/restaurant_home_details_vm.dart';
import 'package:google_fonts/google_fonts.dart';

class BestDealsWidget extends StatelessWidget {
  final RestaurantHomeDetailViewModel viewModel;
  final MainStateController mainStateController;

  const BestDealsWidget(
      {Key? key, required this.viewModel, required this.mainStateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: viewModel.desplayBestDealsByRestaurantId(
            mainStateController.selectedRestaurant.value.restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            var lstBestDeal = snapshot.data as List<PopulerItemModel>;
            return CarouselSlider(
              items: lstBestDeal
                  .map(
                    (e) => Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: e.image,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, err) => Center(
                                      child: Icon(Icons.image),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${e.name}',
                                    style: GoogleFonts.jetBrainsMono(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlayCurve: Curves.easeIn,
                height: double.infinity,
              ),
            );
          }
        },
      ),
    );
  }
}
