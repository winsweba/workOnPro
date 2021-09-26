import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_ordering_app/sate/food_list_state.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailDescriptionWidget extends StatelessWidget {

  final FoodListStateController foodListStateController;

   FoodDetailDescriptionWidget({Key? key, required this.foodListStateController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
Card(
      elevation: 12,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              itemBuilder: (context, _ ){
                return Icon(Icons.star, color: Colors.amber, );
              },
              onRatingUpdate: (value) {},
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${foodListStateController.selectedFood.value.name}',
              style: GoogleFonts.jetBrainsMono(
                  color: Colors.blueGrey,
                  fontSize: 14,),
            ),
            
          ],
        ),
      ),
    );
  }
}