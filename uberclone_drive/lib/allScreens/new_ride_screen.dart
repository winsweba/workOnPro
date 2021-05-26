import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberclone_drive/Assistant/assistant_methodos.dart';
import 'package:uberclone_drive/allWidget/progress_dialog.dart';
import 'package:uberclone_drive/configMaps.dart';
import 'package:uberclone_drive/main.dart';
import 'package:uberclone_drive/models/ride_details.dart';

class NewRideScreen extends StatefulWidget {

  final RideDetails rideDetails;
  NewRideScreen({this.rideDetails});

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newRideGoogleMapController;
  Set<Marker> markersSet = Set<Marker>();
  Set<Circle> circlesSet = Set<Circle>();
  Set<Polyline> polyLineSet = Set<Polyline>();
  List<LatLng> polyLineCorOrdinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double mapPaddingFromTheBottom = 0;

  @override
  void initState() {
    super.initState();
    acceptRideRequest();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPaddingFromTheBottom),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition:  NewRideScreen._kGooglePlex,
            myLocationEnabled: true,
            // zoomControlsEnabled: true,
            // zoomGesturesEnabled: true,
            polylines: polyLineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller ) async {

              _controllerGoogleMap.complete(controller);
              newRideGoogleMapController = controller;

              var  currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude );
              var pickUpLatLng = widget.rideDetails.pickup; 

              setState(() {
                mapPaddingFromTheBottom = 265.0;
              });

              await getPlaceDrection(currentLatLng, pickUpLatLng);
            }
          ),
        
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom:0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              boxShadow: 
              [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ]
            ),

            height: 270,

            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                children: [
                  Text("10 main", 
                  style: TextStyle(fontSize: 14.0, fontFamily: "Brand-Bold", color: Colors.deepPurple),
                  ),

                  SizedBox(height: 6.0,),

                  Row(
                    children: [
                      Text("Wichester Ernest",
                      style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold",),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon( Icons.phone_android ),
                      )
                    ],
                  ),

                  SizedBox(height: 26.0,),

                  Row(
                    children: [
                      Image.asset("images/pickicon.png", height: 16.0, width: 16.0,),
                      SizedBox(width: 18.0,),
                      Expanded(
                        child: Text("Street44 badu town",
                        style: TextStyle(fontSize: 18.0,),
                        overflow: TextOverflow.ellipsis,
                        )
                      )
                    ],
                  ),

                  SizedBox(height: 16.0,),

                  Row(
                    children: [
                      Image.asset("images/desticon.png", height: 16.0, width: 16.0,),
                      SizedBox(width: 18.0,),
                      Expanded(
                        child: Text("Street3338 badu town",
                        style: TextStyle(fontSize: 18.0,),
                        overflow: TextOverflow.ellipsis,
                        )
                      )
                    ],
                  ),

                  SizedBox(height: 26.0,),

                  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0 ),
                          child: RaisedButton(
                            onPressed: (){

                            },
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Arrived", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                                  Icon(Icons.directions_car,color: Colors.white ,size: 26.0,),
                                  ],
                                ),
                              )
                            ),
                          ),
                ],
              ),
            ),
          ),
        )
        ],
      ),
    );
  }

  Future<void> getPlaceDrection(LatLng pickUpLatLng,LatLng dropOffLatLng ) async{
    // var initialPos = Provider.of<AppData>(context, listen:  false).pickUpLcation;
    // var finalPos = Provider.of<AppData>(context, listen:  false).dropOffLocation;

    // var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    // var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProgressDialog(message: "Please Wait...",);
      },
      );

      var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);
      
      // setState(() {
      //   tripDirectionDetails = details;
      // });

      Navigator.pop(context);

      print("This is Encoded Point :: ");
      print(details.encodePoints);

      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolylinePointsResult = polylinePoints.decodePolyline(details.encodePoints);

      polyLineCorOrdinates.clear();

      if(decodedPolylinePointsResult.isNotEmpty){

        decodedPolylinePointsResult.forEach((PointLatLng pointLatLng) { 
          polyLineCorOrdinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude ));
        });
      }

      polyLineSet.clear();

      setState(() {
        
        Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polyLineCorOrdinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
      });

      LatLngBounds latLngBounds;
      if(pickUpLatLng.latitude > dropOffLatLng.latitude && pickUpLatLng.longitude > dropOffLatLng.longitude  ){

        latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng );
      }
      else if(pickUpLatLng.longitude > dropOffLatLng.longitude ){

        latLngBounds = LatLngBounds(southwest:LatLng( pickUpLatLng.latitude, dropOffLatLng.longitude ), northeast: LatLng( dropOffLatLng.latitude, pickUpLatLng.longitude ) );
      }
      else if(pickUpLatLng.latitude > dropOffLatLng.latitude ){

        latLngBounds = LatLngBounds(southwest:LatLng( dropOffLatLng.latitude, pickUpLatLng.longitude ), northeast: LatLng( pickUpLatLng.latitude, dropOffLatLng.longitude ) );
      }
      else{
        latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng );
      }

      newRideGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70) );

      Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        // infoWindow: InfoWindow(title: initialPos.placeName, snippet: " My location "),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"),
      );

      Marker dropOfLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        // infoWindow: InfoWindow(title: finalPos.placeName, snippet: " DropOff location "),
        position: dropOffLatLng,
        markerId: MarkerId("dropOffId"),
      );

      setState( () {
        markersSet.add(pickUpLocMarker);
        markersSet.add(dropOfLocMarker);
      });

      Circle pickUpLocCircle = Circle(
        fillColor: Colors.blueAccent,
        center: pickUpLatLng,
        radius: 12, 
        strokeWidth: 4,
        strokeColor: Colors.blueAccent,
        circleId: CircleId("pickUpId"),
      );

      Circle dropOffLocCircle = Circle(
        fillColor: Colors.deepPurple,
        center: dropOffLatLng,
        radius: 12, 
        strokeWidth: 4,
        strokeColor: Colors.deepPurple,
        circleId: CircleId("dropOffId"),
      );

      setState( () {
        circlesSet.add(pickUpLocCircle);
        circlesSet.add(dropOffLocCircle);
      });
  }

  void acceptRideRequest() {
    String rideRequestId = widget.rideDetails.ride_request_id;
    newRequestRef.child(rideRequestId).child("status").set("accepted");
    newRequestRef.child(rideRequestId).child("driver_name").set(driversInformation.name);
    newRequestRef.child(rideRequestId).child("driver_phone").set(driversInformation.phone);
    newRequestRef.child(rideRequestId).child("driver_id").set(driversInformation.id);
    newRequestRef.child(rideRequestId).child("car_details").set('${driversInformation.car_color} - ${driversInformation.car_model}');

    Map locMap = {
    "latitude": currentPosition.latitude.toString(),
    "longitude": currentPosition.longitude.toString(),
  };

  newRequestRef.child(rideRequestId).child("driver_location").set(locMap);
  }

}