import 'package:admin_olx/MainScreens/adDescription.dart';
import 'package:admin_olx/MainScreens/home.dart';
import 'package:admin_olx/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;


class ApproveAdsScreen extends StatefulWidget {
  @override
  _ApproveAdsScreenState createState() => _ApproveAdsScreenState();
}


class _ApproveAdsScreenState extends State<ApproveAdsScreen>
{
  FirebaseAuth auth = FirebaseAuth.instance;
  String userName;
  String userNumber;
  String itemPrice;
  String itemModel;
  String itemColor;
  String description;
  String urlImage;
  String itemLocation;
QuerySnapshot users;

  Future<bool> showDialogForApprovingAd(selectedDoc) async
  {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(
            "Item Approval",
            style: TextStyle(fontSize: 24, letterSpacing: 2.0, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to approve this item ?"),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text(
                "Cancel",
              ),
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text(
                "Approve Now",
              ),
              onPressed: ()
              {
                Map<String, dynamic> adsData =
                {
                  "status": "approved",
                };
                FirebaseFirestore.instance.collection("items")
                    .doc(selectedDoc)
                    .update(adsData).then((value)
                {
                  print("Ad Approved successfully.");

                  Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
                  Navigator.pushReplacement(context, newRoute);
                });
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;

    Widget showAdsList()
    {
      if(ads != null)
      {
        return ListView.builder(
          itemCount: ads.docs.length,
          padding: EdgeInsets.all(8.0),
          shrinkWrap: true,
          itemBuilder: (context, i)
          {
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [

                  //listtile
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(ads.docs[i].get("imgPro")),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // title: Text(ads.docs[i].get("userName")),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: ()
                            {
                              showDialogForApprovingAd(ads.docs[i].id);
                            },
                            child: Icon(Icons.fact_check_rounded,),
                          ),
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: ()
                            {
                              showDialogForApprovingAd(ads.docs[i].id);
                            },
                            child: Text(
                              "Approve  this ?",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //AdImage
                  GestureDetector(
                    onDoubleTap: ()
                    {
                      Route newRoute = MaterialPageRoute(builder: (_) => AdsDescriptionScreen(
                        title: ads.docs[i].get("itemModel"),
                        itemColor: ads.docs[i].get("itemColor"),
                        userNumber:  ads.docs[i].get("userNumber"),
                        description: ads.docs[i].get("description"),
                        address: ads.docs[i].get("address"),
                        urlImage1: ads.docs[i].get("urlImage1"),
                        urlImage2: ads.docs[i].get("urlImage2"),
                        urlImage3: ads.docs[i].get("urlImage3"),
                        urlImage4: ads.docs[i].get("urlImage4"),
                        urlImage5: ads.docs[i].get("urlImage5"),
                      ));
                      Navigator.pushReplacement(context, newRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image.network(
                        ads.docs[i].get("urlImage1"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Name: " + ads.docs[i].get("userName"),
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //Item Price
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "\$" + ads.docs[i].get("itemPrice"),
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                                child: Text(ads.docs[i].get("itemModel")),
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
                                child: Text(tAgo.format((ads.docs[i].get("time")).toDate())),
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
      else
      {
        return Center(
          child: Text(
            "Loading...",
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: ()
          {
            Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        actions:
        [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: ()
              {
                Route newRoute = MaterialPageRoute(builder: (_) => ApproveAdsScreen());
                Navigator.pushReplacement(context, newRoute);
              },
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.deepPurple,
                Colors.green,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(("Approve New Ads"),),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: _screenWidth,
            child: showAdsList(),
          ),
        ),
      ),
    );
  }
}
