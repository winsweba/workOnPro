import 'dart:io' show Platform;

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberclone_drive/configMaps.dart';
import 'package:uberclone_drive/main.dart';
import 'package:uberclone_drive/models/ride_details.dart';
import 'package:uberclone_drive/notifications/notification_dialog.dart';

class PushNotificationsService{
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future initialize(context) async{

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        retriveRideRequestInfo(getRideRequestId(message), context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        retriveRideRequestInfo(getRideRequestId(message),context);
      },
      onResume: (Map<String, dynamic> message) async {
        retriveRideRequestInfo(getRideRequestId(message),context);
      },
    );

  }

  Future<String> getToken() async{
    String token = await firebaseMessaging.getToken();
    print("This is token :: **************************^^^^^^^^^^^^^^^^&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&************");
    print(token);
    driversRef.child(currentFirebaseUser.uid).child("token").set(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    firebaseMessaging.subscribeToTopic("allusers");

  }

  String getRideRequestId(Map<String, dynamic> message){
    String rideRequestId;

    if(Platform.isAndroid) {
      print("This is ride request id :: ************#################+++++++++++++++++++------------------------------");
       rideRequestId = message["data"]['ride_request_id'];
       print(rideRequestId);
    }
    else{
      print("This is ride request id :: ************#################+++++++++++++++++++------------------------------");
       rideRequestId = message['ride_request_id'];
       print(rideRequestId);
    }

    return rideRequestId;
  }

  void retriveRideRequestInfo(String rideRequestId, BuildContext context){

    newRequestRef.child(rideRequestId).once().then((DataSnapshot dataSnapshot){

      if(dataSnapshot.value != null){
        
        assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
        assetsAudioPlayer.play();

        double dropOffLocationLat = double.parse(dataSnapshot.value['dropoff']['latitude'].toString() );
        double dropOffLocationLng = double.parse(dataSnapshot.value['dropoff']['logitude'].toString() );
        String dropOffAddress = dataSnapshot.value['dropoff_address'].toString();

        double pickUpLocationLat = double.parse(dataSnapshot.value['pickup']['latitude'].toString() );
        double pickUpLocationLng = double.parse(dataSnapshot.value['pickup']['logitude'].toString() );
        String pickUpAddress = dataSnapshot.value['pickup_address'].toString();

        String paymentMethod = dataSnapshot.value['payment_method'].toString();

        RideDetails rideDetails = RideDetails();
        rideDetails.ride_request_id = rideRequestId;
        rideDetails.pickup_address = pickUpAddress;
        rideDetails.dropoff_address = dropOffAddress;
        rideDetails.dropoff = LatLng(dropOffLocationLat, dropOffLocationLng);
        rideDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
        rideDetails.payment_method = paymentMethod;

        print("information ::::::::::::::: ***************** ////////////////////////ooooooo");
        print(rideDetails.dropoff_address);
        print(rideDetails.pickup_address);

        showDialog( 
          context: context,
          barrierDismissible: false, 
          builder: (BuildContext context) => NotificationDialog(rideDetails: rideDetails,) 
          );
        
      }
    });

  }
}