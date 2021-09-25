import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/sate/category_state.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/food_list_strings.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/view_model/category_vm/category_viewmodel_imp.dart';
import 'package:food_ordering_app/widget/category/category_list_widget.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodListScreen extends StatelessWidget {
  // final viewModel = CategoryViewModelImp();
  final CategoryStateController categoryStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryStateController.selectedCategory.value.name,
          style: GoogleFonts.jetBrainsMono(color: Colors.black),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: LiveList(
              showItemDuration: Duration(milliseconds: 300),
              showItemInterval: Duration(milliseconds: 300),
              reAnimateOnVisibility: true,
              scrollDirection: Axis.vertical,
              itemCount:
                  categoryStateController.selectedCategory.value.foods.length,
              itemBuilder: animationItemBuilder(
                (index) => InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 6 * 2,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: categoryStateController
                                .selectedCategory.value.foods[index].image,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, err) => Center(
                              child: Icon(Icons.image),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Color(COLOR_OVERLAY),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${categoryStateController.selectedCategory.value.foods[index].name}',
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.jetBrainsMono(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),

                                            Text(
                                              '$priceText: \$${categoryStateController.selectedCategory.value.foods[index].price}',
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.jetBrainsMono(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),

                                            Row(
                                              children: [
                                                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border, color: Colors.white,)),

                                                SizedBox(width: 50,),

                                                IconButton(onPressed: () {}, icon: Icon(Icons.add_shopping_cart, color: Colors.white,))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
