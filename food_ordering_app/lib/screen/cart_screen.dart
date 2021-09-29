import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_ordering_app/sate/cart_state.dart';
import 'package:food_ordering_app/strings/cart_strings.dart';
import 'package:food_ordering_app/utils/utils.dart';
import 'package:food_ordering_app/view_model/cart_vm/cart_view_model_imp.dart';
import 'package:food_ordering_app/widget/cart/cart_image_widget.dart';
import 'package:food_ordering_app/widget/cart/cart_info_widget.dart';
import 'package:food_ordering_app/widget/cart/cart_total_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class CartDetailScreen extends StatelessWidget {
  final box = GetStorage();
  final CartStateController controller = Get.find();
  final CartViewModelImp cartViewModel = new CartViewModelImp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          controller.getQuantity() > 0
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.clear),
                )
              : Container(),
        ],
      ),
      body: controller.getQuantity() > 0
          ? Obx(
              () => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cart.length,
                      itemBuilder: (context, index) => Slidable(
                        child: Card(
                          elevation: 8.0,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 6.0,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: CartImageWidget(
                                      controller: controller,
                                      cartModel: controller.cart[index],
                                    )),
                                Expanded(
                                  flex: 6,
                                  child: CartInfo(
                                      cartModel: controller.cart[index]),
                                ),
                                Center(
                                  child: ElegantNumberButton(
                                    initialValue:
                                        controller.cart[index].quantity,
                                    minValue: 1,
                                    maxValue: 100,
                                    color: Colors.amber,
                                    onChanged: (value) {
                                      cartViewModel.updateCart(controller, index, value.toInt());
                                    },
                                    decimalPlaces: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: [
                          IconSlideAction(
                            caption: deleteText,
                            icon: Icons.delete,
                            color: Colors.red,
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  ),

                  TotalWidget(controller: controller,),
                ],
              ),
            )
          : Center(
              child: Text(cartEmptyText),
            ),
    );
  }
}


// Card(
//                     elevation: 12,
//                     child: Padding(padding: EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children:[
//                             Text(
//                               totalText,
//                               style: GoogleFonts.jetBrainsMono(
//                                 fontSize: 20, fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               totalText,
//                               style: GoogleFonts.jetBrainsMono(
//                                 fontSize: 20, fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ]
//                         )
//                       ],
//                     ),
//                      ) ,
//                   ),