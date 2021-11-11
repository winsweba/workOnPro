import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olx_app/Welcome/welcome_screen.dart';
import 'package:olx_app/otherScreens/details_screen.dart';
import 'package:olx_app/otherScreens/global_avaribles.dart';
import 'package:olx_app/otherScreens/info_screen.dart';
import 'package:olx_app/otherScreens/payment_screen.dart';
import 'package:olx_app/otherScreens/profileScreen.dart';
import 'package:olx_app/otherScreens/search_product.dart';
import 'package:olx_app/otherScreens/uploadAddScreen.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:toast/toast.dart';
import 'package:firebase_admob/firebase_admob.dart';

class HomeScreene extends StatefulWidget {

  @override
  _HomeScreeneState createState() => _HomeScreeneState();
}

class _HomeScreeneState extends State<HomeScreene> {

  FirebaseAuth auth = FirebaseAuth.instance;

  QuerySnapshot items;
  

void showToast(String msg,BuildContext context ,{int duration, int gravity}){
    Toast.show( msg, context, duration: duration, gravity: gravity);
  }
  
  Future<bool> showDialogForUpdateDate(selectedDoc, oldUserName, oldPhoneNumber, oldItemPrice, oldItemName, oldItemColor, oldItemDescription) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text("Update Data", style: TextStyle(fontSize: 24, fontFamily: "Bebas", letterSpacing: 2.0  ) ,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: oldUserName,
                  decoration: InputDecoration(
                    hintText: "Eneter Your Name",
                  ),
                  onChanged: (value) {
                    setState(() {
                        oldUserName = value;
                                        });
                  },
                ),
                
                SizedBox(height: 5.0,),

                TextFormField(
                  initialValue: oldPhoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Eneter Your Phone Number",
                  ),
                  onChanged: (value) {
                    setState(() {
                        oldPhoneNumber = value;
                                        });
                  },
                ),
                
                SizedBox(height: 5.0,),

                TextFormField(
                  initialValue: oldItemPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Eneter Item Price ",
                  ),
                  onChanged: (value) {
                    setState(() {
                        oldItemPrice = value;
                                        });
                  },
                ),
                
                
                SizedBox(height: 5.0,),

                TextFormField(
                  initialValue: oldItemName,
                  decoration: InputDecoration(
                    hintText: "Eneter Item Name ",
                  ),
                  onChanged: (value) {
                    setState(() {
                        oldItemName = value;
                                        });
                  },
                ),
                
                
                SizedBox(height: 5.0,),

                TextFormField(
                  initialValue: oldItemColor,
                  decoration: InputDecoration(
                    hintText: "Eneter Item Color ",
                  ),
                  onChanged: (value) {
                    setState(() {
                        oldItemColor = value;
                                        });
                  },
                ),
                
                
                SizedBox(height: 5.0,),

                TextFormField(
                  initialValue: oldItemDescription,
                  decoration: InputDecoration(
                    hintText: "Eneter Item Description ",
                  ),
                  onChanged: (value) {
                    setState(() {
                        oldItemDescription = value;
                                        });
                  },
                ),

                SizedBox(height: 5.0,),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              ElevatedButton(
                child: Text("Udate Now"),
                onPressed: () {
                  if(oldUserName == '' ){
                    showToast("Name Is needed", context, duration: 2, gravity: Toast.CENTER) ;
                  }
                  else if(oldPhoneNumber == '' ){
                    showToast("Phone Number Is needed", context, duration: 2, gravity: Toast.CENTER) ;
                  }
                  else if(oldItemPrice == '' ){
                    showToast("Item Price Is needed", context, duration: 2, gravity: Toast.CENTER) ;
                  }
                  else if(oldItemName == '' ){
                    showToast("Item Name Is needed", context, duration: 2, gravity: Toast.CENTER) ;
                  }
                  else if(oldItemColor == '' ){
                    showToast("Item Color Is needed", context, duration: 2, gravity: Toast.CENTER) ;
                  }
                  else if(oldItemDescription== '' ){
                    showToast("Item Description Is needed", context, duration: 2, gravity: Toast.CENTER) ;
                  }
                  else{
                    Navigator.pop(context);
                    Map<String, dynamic> itemData = {
                    'userName': oldUserName,
                    'userNumber': oldPhoneNumber,
                    'itemPrice': oldItemPrice,
                    'itemModel': oldItemName,
                    'itemColor': oldItemColor,
                    'description': oldItemDescription,
                  };

                  FirebaseFirestore.instance.collection("items").doc(selectedDoc).update(itemData).then((value) {
                    print("Data Upatated Successfully");
                  }).catchError((onError){
                    print(onError);
                  });
                  }
                  
                },
              ),
            ],
          ),
        );
      }
    );
  }

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




///////////////////////////////////// Admob ////////////////////////////////

      FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-2635835949649414~7809170937');
    _bannerAd = createBannerAdd()..load();
    _interstitialAd = createInterstitialAd()..load();


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
                        onTap: () {
                          Route newRoute = MaterialPageRoute(builder: (context) => ProfileScreen(sellerId: items.docs[i].get('uId'),));
                          Navigator.pushReplacement(context, newRoute); 
                        },

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
                        onTap: () {
                          Route newRoute = MaterialPageRoute(builder: (context) => ProfileScreen(sellerId: items.docs[i].get('uId'),));
                          Navigator.pushReplacement(context, newRoute); 
                        },

                        child: Text(items.docs[i].get("userName"),
                        ),
                        ),
                        trailing: items.docs[i].get("uId") == userId ? 
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(items.docs[i].get('uId') == userId ) {
                                  showDialogForUpdateDate(
                                    items.docs[i].id,
                                    items.docs[i].get('userName'),
                                    items.docs[i].get('userNumber'),
                                    items.docs[i].get('itemPrice'),
                                    items.docs[i].get('itemModel'),
                                    items.docs[i].get('itemColor'),
                                    items.docs[i].get('description'),
                                  );
                                }
                              },

                              child: Icon(Icons.edit_outlined),
                            ),

                            SizedBox(width: 20,),
                            
                            GestureDetector(
                              onDoubleTap: () {
                                if(items.docs[i].get('uId') == userId ){
                                  FirebaseFirestore.instance.collection('items').doc(items.docs[i].id).delete();
                                  Route newRoute = MaterialPageRoute(builder: (context) => HomeScreene());
                                  Navigator.push(context, newRoute);
                                }
                              },

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
                      // Route newRoute = MaterialPageRoute(builder: (context) => ImageSliderScreen(
                      //   title: items.docs[i].get("itemModel"),
                      //   itemColor: items.docs[i].get("itemColor"),
                      //   userNumber:  items.docs[i].get("userNumber"),
                      //   description: items.docs[i].get("description"),
                      //   lat: items.docs[i].get("lat"),
                      //   lng: items.docs[i].get("lng"),
                      //   address: items.docs[i].get("address"),
                      //   urlImage1: items.docs[i].get("urlImage1"),
                      //   urlImage2: items.docs[i].get("urlImage2"),
                      //   urlImage3: items.docs[i].get("urlImage3"),
                      //   urlImage4: items.docs[i].get("urlImage4"),
                      //   urlImage5: items.docs[i].get("urlImage5"),
                      // ));
                      // Navigator.pushReplacement(context, newRoute);


                       Route newRoute = MaterialPageRoute(builder: (context) => DetailsScreen(
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
                      Navigator.push(context, newRoute);
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(items.docs[i].get('urlImage1'), fit: BoxFit.fill, ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "GHS " + items.docs[i].get("itemPrice"),
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
        return Center(child: CircularProgressIndicator(),);
      }
    }

    //// Admob
    /// 
    Timer(Duration(seconds: 10), () {
      _bannerAd?.show(anchorType: AnchorType.bottom, anchorOffset: kBottomNavigationBarHeight);
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh, color: Colors.white,),
          onPressed: () {
            Route newRoute = MaterialPageRoute(builder: (context) => HomeScreene());
                Navigator.pushReplacement(context, newRoute);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              
              _bannerAd?.dispose();
                _bannerAd = null;

              Route newRoute = MaterialPageRoute(builder: (context) => ProfileScreen(sellerId: userId));
                Navigator.push(context, newRoute);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.person, color: Colors.white, ),
            ),
          ),
          TextButton(
            onPressed: () {
              Route newRoute = MaterialPageRoute(builder: (context) => SearchProduct());
                Navigator.push(context, newRoute);
            },
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
          TextButton(
            onPressed: () {
              _bannerAd?.dispose();
                _bannerAd = null;
                _interstitialAd?.show();
              Route newRoute = MaterialPageRoute(builder: (context) => InfoScreen());
              Navigator.push(context, newRoute);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.info, color: Colors.white, ),
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

        Route newRoute = MaterialPageRoute(builder: (context) => PaymentScreen());
        Navigator.push(context, newRoute);
     
        // Route newRoute = MaterialPageRoute(builder: (context) => UploadAddScreen());
        // Navigator.pushReplacement(context, newRoute);

        },
      ),
    );


    
    
  }

  

  ///////////////// Ad Mob 
  ///
  ///
  /// 
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo();
  // int _coins = 0;
  // final _nativeAdController = NativeAdmobController();
  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId: "ca-app-pub-2635835949649414/9170810913",
        listener: (MobileAdEvent event) {
          print('interstitial event: $event');
        });
  }

  BannerAd createBannerAdd() {
    return BannerAd(
        targetingInfo: targetingInfo,
        adUnitId: 'ca-app-pub-2635835949649414/9747711208',
        size: AdSize.smartBanner,
        listener: (MobileAdEvent event) {
          print('Bnner Event: $event');
        });
  }






  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}