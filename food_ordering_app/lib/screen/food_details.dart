import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:food_ordering_app/const/const.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/models/size_model.dart';
import 'package:food_ordering_app/sate/category_state.dart';
import 'package:food_ordering_app/sate/food_detail_state.dart';
import 'package:food_ordering_app/sate/food_list_state.dart';
import 'package:food_ordering_app/sate/main_state.dart';
import 'package:food_ordering_app/strings/food_detail_string.dart';
import 'package:food_ordering_app/strings/food_list_strings.dart';
import 'package:food_ordering_app/strings/restaurant_home_string.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:food_ordering_app/view_model/category_vm/category_viewmodel_imp.dart';
import 'package:food_ordering_app/widget/category/category_list_widget.dart';
import 'package:food_ordering_app/widget/common/common_widget.dart';
import 'package:food_ordering_app/widget/food_details/food_detail_image_widget.dart';
import 'package:food_ordering_app/widget/food_details/food_detail_name_widget.dart';
import 'package:food_ordering_app/widget/food_details/food_detail_size_widget.dart';
import 'package:food_ordering_app/widget/food_details/food_details_description_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailScreen extends StatelessWidget {
  // final viewModel = CategoryViewModelImp();
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController = Get.find();
  final FoodDetailStateController foodDetailStateController =
      Get.put(FoodDetailStateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                '${foodListStateController.selectedFood.value.name}',
                style: GoogleFonts.jetBrainsMono(color: Colors.black),
              ),
              elevation: 10,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              foregroundColor: Colors.black,
              bottom: PreferredSize(
                preferredSize: Size.square(foodDetailImageAreaSize(context)),
                child: FoodDetailImageWidget(
                  foodListStateController: foodListStateController,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FoodDetailNameWidget(
                  foodListStateController: foodListStateController,
                  foodDetailStateController: foodDetailStateController,
                ),
                FoodDetailDescriptionWidget(
                    foodListStateController: foodListStateController),

                //Chee if food have size
                FoodDetailSizeWidget(
                    foodListStateController: foodListStateController,
                    foodDetailStateController: foodDetailStateController),

                Card(
                  elevation: 12,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => ExpansionTile(
                              title: Text(
                                addonText,
                                style: GoogleFonts.jetBrainsMono(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              ),
                              children: [
                                Wrap(
                                  children: foodListStateController
                                      .selectedFood.value.addon
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.all(8),
                                          child: ChoiceChip(
                                            label: Text(e.name),
                                            selected: foodDetailStateController
                                                .selectedAddon
                                                .contains(e),
                                                selectedColor: Colors.yellow,
                                            onSelected: (selected) => selected
                                                ? foodDetailStateController
                                                    .selectedAddon
                                                    .add(e)
                                                : foodDetailStateController
                                                    .selectedAddon
                                                    .remove(e),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
