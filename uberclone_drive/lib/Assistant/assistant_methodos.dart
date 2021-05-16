import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uberclone_drive/Assistant/request_assistant.dart';
import 'package:uberclone_drive/DataHandler/app_data.dart';
import 'package:uberclone_drive/configMaps.dart';
import 'package:uberclone_drive/models/address.dart';
import 'package:uberclone_drive/models/all_users.dart';
import 'package:uberclone_drive/models/directionDetails.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress( Position position, context ) async{

    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed" ){
      
      //placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      // st3 = response["results"][0]["address_components"][6]["long_name"];
      // st4 = response["results"][0]["address_components"][9]["long_name"];
      // placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4 ;
      placeAddress = st1 + ", " + st2;

      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false ).updatePickUpLcationAddress(userPickUpAddress);
    }

    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition ) async {
    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if(res == "failed"){

      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodePoints = res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static int colculateFares(DirectionDetails directionDetails ) {

    // in terms USD
    double timeTraveledFare = (directionDetails.durationValue / 60 ) * 0.20;
    double directionTraveledFare = (directionDetails.distanceValue / 1000 ) * 0.20;
    double totalFareAmount = timeTraveledFare + directionTraveledFare;

    //Local Currency
    // $1 = 160 RS
    // double totalLocalAmount = totalFareAmount * 160;

    return totalFareAmount.truncate();
  }

  static void getCurrentOnlineUserInf() async {

    firebaseUser = await FirebaseAuth.instance.currentUser;
    String userId = firebaseUser.uid;
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").child(userId);

    reference.once().then((DataSnapshot dataSnapshot) {
      if(dataSnapshot.value != null ){
        usersCurrentInfo = Users.fromSnapshot(dataSnapshot);
      }
    });
  }

}