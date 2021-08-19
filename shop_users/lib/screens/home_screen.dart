import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_users/Animation/FadeAnimation.dart';
import 'package:shop_users/block/toast_mg_block.dart';
import 'package:shop_users/screens/Welcome/welcome_screen.dart';
import 'package:shop_users/screens/cart_page.dart';
import 'package:shop_users/screens/shoes.dart';
import 'package:shop_users/block/items_black.dart';
import 'package:shop_users/model/cart_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<CartItemBlock>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoppig App"),
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
          IconButton(icon: Icon(Icons.shopping_basket_sharp), onPressed: () {
            Navigator.push(
                        context,
                        new MaterialPageRoute(
                          //TODO Add  this
                          builder: (context) => CartPage(),
                        ),
                      );
          }),
        ],
      ),
      body: StreamBuilder<List<CartItem>>(
          stream: cartItems.fetchUpcomingProduct,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var cartItem = snapshot.data[index];
                return FadeAnimation(
                  2.1,
                  BuildImageInteractionCard(
                    image: cartItem.imgUrl,
                    title: cartItem.title,
                    price: cartItem.price,
                    tag: cartItem.title,
                    description: cartItem.description,
                  ),
                );
              },
            );
          }),
    );
  }
}

class BuildImageInteractionCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final String tag;
  final String description;

  BuildImageInteractionCard({
    this.image,
    this.price,
    this.title,
    this.tag,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      child: Column(
        children: [
          Hero(
            tag: tag,
            child: Stack(
              children: [
                Ink.image(
                  image: NetworkImage(image),
                  height: 200,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Shoes(
                                    image: image,
                                    description: description,
                                    title: title,
                                    price: price,
                                    tag: tag,
                                  )));
                    },
                  ),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 150,
                  right: 16,
                  left: 16,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 16,
                  child: Text(
                    '${price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 0,
                  left: 16,
                  child: Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(16).copyWith(bottom: 0),
          //   child: Text(
          //     description,
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),
        ],
      ),
    );
  }
}
