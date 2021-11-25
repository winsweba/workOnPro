import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:olx_app/otherScreens/home_screene.dart';

class GetHomeScreen extends StatefulWidget {
  @override
  State<GetHomeScreen> createState() => _GetHomeScreenState();

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo();
}

class _GetHomeScreenState extends State<GetHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///////////////////////////////////// Admob ////////////////////////////////

    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-2635835949649414~7809170937');
    _bannerAd = createBannerAdd()..load();
    _interstitialAd = createInterstitialAd()..load();
  }

  @override
  Widget build(BuildContext context) {
    //// Admob
    ///
    Timer(Duration(seconds: 10), () {
      _bannerAd?.show(
          anchorType: AnchorType.bottom,
          anchorOffset: kBottomNavigationBarHeight);
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Product will be approved \nwithin 24 hours.",
                style: TextStyle(fontFamily: "Lobster", fontSize: 22),
              ),
              Text(
                "If not you can contact \n Adim at winsweba@gmail.com",
                style: TextStyle(fontFamily: "Lobster", fontSize: 22),
              ),
              Text(
                "OR",
                style: TextStyle(fontFamily: "Lobster", fontSize: 30),
              ),
              Text(
                "Call or What's App me at 0241012217",
                style: TextStyle(fontFamily: "Lobster", fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _bannerAd?.dispose();
                  _bannerAd = null;
                  _interstitialAd?.show();
                  // Route newRoute = MaterialPageRoute(builder: (context) => HomeScreene());
                  // Navigator.pushReplacement(context, newRoute);
                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreene(),
                    ),

                    // this function should return true when we're done removing routes
                    // but because we want to remove all other screens, we make it
                    // always return false
                    (Route route) => false,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Go to home page",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///////////////// Ad Mob
  ///
  ///
  ///
  BannerAd _bannerAd;

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        targetingInfo: GetHomeScreen.targetingInfo,
        adUnitId: "ca-app-pub-2635835949649414/9170810913",
        listener: (MobileAdEvent event) {
          print('interstitial event: $event');
        });
  }

  BannerAd createBannerAdd() {
    return BannerAd(
        targetingInfo: GetHomeScreen.targetingInfo,
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
