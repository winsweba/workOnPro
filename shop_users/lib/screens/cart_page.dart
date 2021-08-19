import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_users/Animation/FadeAnimation.dart';
import 'package:shop_users/block/toast_mg_block.dart';
import 'package:shop_users/model/added_cart_info_model.dart';
import 'package:shop_users/screens/Welcome/welcome_screen.dart';
import 'package:shop_users/screens/shoes.dart';
import 'package:shop_users/block/items_black.dart';
import 'package:shop_users/model/cart_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String userId;
  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<CartItemBlock>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart page"),
        centerTitle: true,
        backgroundColor: Colors.black45,
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.outbond_outlined),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            displayToastMessage("You are now Logged Out", context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.shopping_basket_sharp), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<List<AddedCartInfoModel>>(
          stream: cartItems.fetchUpcomingProductToCart(userId),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var cart = snapshot.data[index];
                return  BuildImageInteractionCart(
                    image: cart.imgUrl,
                    title: cart.title,
                    price: cart.price,
                );
              },
            );
          }),
    );
  }
}

class BuildImageInteractionCart extends StatelessWidget {
  final String image;
  final String title;
  final double price;

  const BuildImageInteractionCart({this.image, this.title, this.price});

  

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Ink.image(
                        // image: AssetImage('assets/images/three.jpg'),
                        image: NetworkImage(image),
                        height: 120,
                        width: 120,
                        child: InkWell(),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5).copyWith(bottom: 0),
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5).copyWith(bottom: 0),
                        child: Text(
                          "${price}",
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 400,),
                Text("80"),
                SizedBox(height: 16,),
                Text("Buy Now"),
              ],
            ),
          ),
    );
  }
}

// class BuildImageInteractionCart extends StatelessWidget {
//   final String image;
//   final String title;
//   final double price;

//   BuildImageInteractionCart({
//     this.image,
//     this.price,
//     this.title, 
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       elevation: 8,
//       child: Column(
//         children: [
//           Hero(
//             // tag: tag,
//             child: Stack(
//               children: [
//                 Ink.image(
//                   image: NetworkImage(image),
//                   height: 200,
//                   child: InkWell(
//                     onTap: () {
                     
//                     },
//                   ),
//                   fit: BoxFit.cover,
//                 ),
                
//                 Positioned(
//                   bottom: 150,
//                   right: 16,
//                   left: 16,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   right: 0,
//                   left: 16,
//                   child: Text(
//                    '${price}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 // Positioned(
//                 //   bottom: 50,
//                 //   right: 0,
//                 //   left: 16,
//                 //   child: Text(
//                 //    description,
//                 //     style: TextStyle(
//                 //       fontWeight: FontWeight.bold,
//                 //       color: Colors.black,
//                 //       fontSize: 24,
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           // Padding(
//           //   padding: EdgeInsets.all(16).copyWith(bottom: 0),
//           //   child: Text(
//           //     description,
//           //     style: TextStyle(fontSize: 16),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
