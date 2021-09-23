import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/populer_item_model.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/view_model/restaurent_home_vm/restaurant_home_vm.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MostPopularWidget extends StatelessWidget {
  final RestaurantHomeViewModel viewModel;
  final MainStateController mainStateController;

  const MostPopularWidget(
      {Key? key, required this.viewModel, required this.mainStateController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: viewModel.desplayMostPopulerByRestaurantId(
            mainStateController.selectedRestaurant.value.restaurantId),
        builder: (context, snapshoit) {
          if (snapshoit.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lstPopular = snapshoit.data as List<PopulerItemModel>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mostPopularText,
                  style: GoogleFonts.jetBrainsMono(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black45),
                ),
                Expanded(
                  child: LiveList(
                    showItemDuration: Duration(milliseconds: 350),
                    showItemInterval: Duration(milliseconds: 150),
                    reAnimateOnVisibility: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: lstPopular.length,
                    itemBuilder: animationItemBuilder(
                      (index) => Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(lstPopular[index].image),
                              minRadius: 40,
                              maxRadius: 60,
                            ),
                            SizedBox(height: 10),
                            Text(
                              lstPopular[index].name,
                              style: GoogleFonts.jetBrainsMono(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
