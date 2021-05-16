import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberclone_drive/Assistant/assistant_methodos.dart';

class HomeTabPage extends StatelessWidget {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Position currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high ); 
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom:  14 );
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition) );

    // String address = await AssistantMethods.searchCoordinateAddress(position, context);
    // print ("This is your Address :: " + address);
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition:  _kGooglePlex,
            myLocationEnabled: true,
            // zoomControlsEnabled: true,
            // zoomGesturesEnabled: true,
            // polylines: polylineSet,
            // markers: markersSet,
            // circles: circlesSet,
            onMapCreated: (GoogleMapController controller ){

              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locatePosition();
            }
          ),

          //Online Offline driver container
           Container(
             height: 140.0,
             width: double.infinity,
             color: Colors.black54, 
           ),

           Positioned(
             top: 60.0,
             left: 0.0,
             right: 0.0,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center ,
               children: [
                 Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0 ),
                            child: RaisedButton(
                              onPressed: (){
                                
                              },
                              color: Colors.green,
                              child: Padding(
                                padding: EdgeInsets.all(17.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Online now ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                                    Icon(Icons.phone_android, color: Colors.white ,size: 26.0,),
                                    ],
                                  ),
                                )
                              ),
                            ),
               ],
             ),
           ),
      ],
    );
  }
}