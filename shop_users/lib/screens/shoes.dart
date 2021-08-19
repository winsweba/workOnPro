import 'package:flutter/material.dart';
import 'package:shop_users/Animation/FadeAnimation.dart';
import 'package:shop_users/block/toast_mg_block.dart';
import 'package:shop_users/servers/firestore_servers.dart';

class Shoes extends StatefulWidget {
  final String image;
  final String description;
  final String title;
  final double price;
  final String tag;


   const Shoes({Key key, this.image, this.description, this.title, this.price, this.tag}) : super(key: key);

  @override
  _ShoesState createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Hero(
          tag: widget.tag,
          child: Container(
            height: MediaQuery.of(context).size.height,
            // height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image,),
                fit: BoxFit.contain
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 10,
                  offset: Offset(0, 10)
                )
              ]
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: Center(
                          child: Text("${widget.price}",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 40,
                    ),)
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: FadeAnimation(1, Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.0),
                        ]
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FadeAnimation(1.3, Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),)),
                        SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(1.5, Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              margin: EdgeInsets.only(right: 20),
                              child: Center(
                                child: Text(widget.description, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: 60,),
                        FadeAnimation(1.5, GestureDetector(
                          onTap: (){
                           addToCart(context);
                          },
                          child: Container(
                            height: 35,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Icon(Icons.shopping_bag),),
                            ),
                        ),
                        ),
                        SizedBox(height: 10,),
                        
                        FadeAnimation(1.5, Container(
                          height: 30,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text('Buy Now', style: TextStyle(fontWeight: FontWeight.bold),)
                          ),
                        )),
                        SizedBox(height: 30,),
                      ],
                    ),
                  )),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  void addToCart(BuildContext context){
    try{
      addToCartInfo(widget.price, widget.image, widget.title, );
      displayToastMessage('All is added ', context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Shoes(image: widget.image,title: widget.title,)));
    }catch(e){
            print(e.toString());
            displayToastMessage("Error:::: " + e.toString(),context);
          }
  }
}