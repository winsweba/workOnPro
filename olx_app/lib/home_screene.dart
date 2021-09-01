import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olx_app/Welcome/welcome_screen.dart';
import 'package:olx_app/global_avaribles.dart';
import 'package:olx_app/image_slider_screen.dart';
import 'package:olx_app/uploadAddScreen.dart';
import 'package:timeago/timeago.dart' as tAgo;

class HomeScreene extends StatefulWidget {

  @override
  _HomeScreeneState createState() => _HomeScreeneState();
}

class _HomeScreeneState extends State<HomeScreene> {

  FirebaseAuth auth = FirebaseAuth.instance;

  QuerySnapshot items;

  getMyData() {
    FirebaseFirestore.instance.collection("users").doc(userId).get().then((results) {
      setState(() {
              userImageUrl = results.data()['imagePro'];
              getUserName = results.data()['userName'];
            });
    });
  }
  

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getUserAddress();

      userId = FirebaseAuth.instance.currentUser.uid;
      userEmail = FirebaseAuth.instance.currentUser.email;

      FirebaseFirestore.instance.collection("items")
      .where("status", isEqualTo: "approved")
      .orderBy("time", descending: true)
      .get().then((result) {
        setState(() {
                  items = result;
                });
      });

      getMyData();

    }

  getUserAddress() async{
    Position newPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high );

    position = newPosition;

    placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placemark = placemarks[0];

    String newCompleteAddress = 
    '${placemark.subThoroughfare} ${placemark.thoroughfare}, '
    '${placemark.subThoroughfare} ${placemark.locality}, '
    '${placemark.subAdministrativeArea}, '
    '${placemark.administrativeArea} ${placemark.postalCode}, '
    '${placemark.country}';

    completeAddress = newCompleteAddress;
    print(completeAddress);

    return completeAddress;
  }

  
  

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
    _screenHeight = MediaQuery.of(context).size.height;

    Widget showItemList() {
      
      if(items != null ) {
        return ListView.builder(
          itemCount: items.docs.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, i) {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {},

                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(items.docs[i].get("imgPro")),
                            fit: BoxFit.fill,
                          ),
                        ),
                        ),
                      ) ,
                      title: GestureDetector(
                        onTap: () {},

                        child: Text(items.docs[i].get("userName"),
                        ),
                        ),
                        trailing: items.docs[i].get("uId") == userId ? 
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {},

                              child: Icon(Icons.edit_outlined),
                            ),

                            SizedBox(width: 20,),
                            
                            GestureDetector(
                              onDoubleTap: () {},

                              child: Icon(Icons.delete_forever_sharp),
                            ),
                          ],
                        )  : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [],
                        ),
                    ),
                  ),

                  GestureDetector(
                    onDoubleTap: () {
                      Route newRoute = MaterialPageRoute(builder: (context) => ImageSliderScreen(
                        title: items.docs[i].get("itemModel"),
                        itemColor: items.docs[i].get("itemColor"),
                        userNumber:  items.docs[i].get("userNumber"),
                        description: items.docs[i].get("description"),
                        lat: items.docs[i].get("lat"),
                        lng: items.docs[i].get("lng"),
                        address: items.docs[i].get("address"),
                        urlImage1: items.docs[i].get("urlImage1"),
                        urlImage2: items.docs[i].get("urlImage2"),
                        urlImage3: items.docs[i].get("urlImage3"),
                        urlImage4: items.docs[i].get("urlImage4"),
                        urlImage5: items.docs[i].get("urlImage5"),
                      ));
                      Navigator.pushReplacement(context, newRoute);
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(items.docs[i].get('urlImage1'), fit: BoxFit.fill, ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "\$" + items.docs[i].get("itemPrice"),
                      style: TextStyle(
                        fontFamily: "Babas",
                        letterSpacing: 2.0,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  

                  //model & time
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //itemModel
                        Row(
                          children: [
                            Icon(Icons.image_sharp),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(items.docs[i].get("itemModel")),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ],
                        ),

                        //time ago
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(tAgo.format((items.docs[i].get("time")).toDate())),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0,),
                ],
              ),
            );
          },
        );
      }
      else{
        return Text('Loading.........');
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh, color: Colors.white,),
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.person, color: Colors.white, ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.search, color: Colors.white, ),
            ),
          ),
          TextButton(
            onPressed: () {
              auth.signOut().then((_){
                Route newRoute = MaterialPageRoute(builder: (context) => WelcomeScreen());
                Navigator.pushReplacement(context, newRoute);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.login_outlined, color: Colors.white, ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Colors.deepPurple[300],
                Colors.deepPurple
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text('Home Page'),
        centerTitle: false,
      ),
      body: Center(
        child: Container(
          width: _screenWidth,
          child: showItemList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add post',
        child: Icon(Icons.add),
        onPressed: () {
          Route newRoute = MaterialPageRoute(builder: (context) => UploadAddScreen());
          Navigator.pushReplacement(context, newRoute);
        },
      ),
    );
  }
}