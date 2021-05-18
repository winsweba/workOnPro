import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uberclone/Assistant/assistant_methodos.dart';
import 'package:uberclone/Assistant/geofire_assistant.dart';
import 'package:uberclone/DataHandler/app_data.dart';
import 'package:uberclone/allScreens/login_screen.dart';
import 'package:uberclone/allScreens/search_screen.dart';
import 'package:uberclone/allWidget/divider.dart';
import 'package:uberclone/allWidget/progress_dialog.dart';
import 'package:uberclone/configMaps.dart';
import 'package:uberclone/models/directionDetails.dart';
import 'package:uberclone/models/nearby_available_drivers.dart';

class MainScreen extends StatefulWidget {
  
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin  {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDatailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double seachContainerHeight = 300.0;

  bool drawerOpen = true;
  bool nearbyAvailableDriverKeysLoaded = false;

  DatabaseReference rideRequestRef;

  @override
 void initState(){

   super.initState();

   AssistantMethods.getCurrentOnlineUserInf();
  }

  void saveRideRequest(){
    rideRequestRef = FirebaseDatabase.instance.reference().child("Ride Requests").push();

    var pickUp = Provider.of<AppData>(context, listen: false).pickUpLcation;
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;

    Map pickUpLocMap = {
      "latitude": pickUp.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
    };

    Map dropOffLocMap = {
      "latitude": dropOff.latitude.toString(),
      "longitude": dropOff.longitude.toString(),
    };

    Map rideInfoMap = {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": pickUpLocMap,
      "dropoff": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "rider_name": usersCurrentInfo.name,
      "ride_phone": usersCurrentInfo.phone,
      "pickup_address": pickUp.placeName,
      "dropoff_addresss": dropOff.placeName,
    };
    rideRequestRef.set(rideInfoMap);
  }

  void canceliRideRequest() {
    rideRequestRef.remove();
  }

  void displayRequestRideContainer(){
    setState(() {
    requestRideContainerHeight = 250.0;
    rideDatailsContainerHeight = 0;
    bottomPaddingOfMap = 230.0;
    drawerOpen = true;
    });

    saveRideRequest();

  }

  resetApp(){
    setState((){
      drawerOpen = true;

      seachContainerHeight = 300.0;
      rideDatailsContainerHeight = 0.0;
      requestRideContainerHeight = 0.0;
      bottomPaddingOfMap = 230.0;
      
      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();
    });

    locatePosition();
  }

  void displayRideDetailsContainer() async {
    await getPlaceDrection();

    setState((){

      seachContainerHeight = 0.0;
      rideDatailsContainerHeight = 240.0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = false;
    });

  }

  Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high ); 
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom:  14 );
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition) );

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print ("This is your Address :: " + address);

    initGeofireListner();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Hearder
              Container(
                height: 165.0,
                child: DrawerHeader( 
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                      SizedBox(height: 16, ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Proflie Name", style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold" ),),
                          SizedBox(height: 6.0),
                          Text("Visit Profile"),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              DividerWidget(),

              SizedBox(height: 12.0,),

              ListTile(
                leading: Icon(Icons.history ),
                title: Text("History", style: TextStyle(fontSize: 15.0) ),
              ),
              ListTile(
                leading: Icon(Icons.person ),
                title: Text("Visit Profile", style: TextStyle(fontSize: 15.0) ),
              ),
              ListTile(
                leading: Icon(Icons.info ),
                title: Text("About", style: TextStyle(fontSize: 15.0) ),
              ),
              GestureDetector(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen , (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.info ),
                  title: Text("Sign Out", style: TextStyle(fontSize: 15.0) ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap ),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition:  _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller ){

              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              locatePosition();
            }
          ),

          //HanburgerButton for Drawer
          
          Positioned(
            top: 38.0,
            left: 22.0,
            child: GestureDetector(
              onTap: (){
                
                if(drawerOpen) {
                  scaffoldKey.currentState.openDrawer();
                }
                else{
                  resetApp();
                } 

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7
                      )
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon((drawerOpen) ? Icons.menu : Icons.close , color: Colors.black , ),
                  radius: 20.0,
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),

              child: Container(

                height: seachContainerHeight,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular( 18.0), topRight: Radius.circular( 18.0) ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0 ),
                  child: Column(
                    children: [
                      SizedBox(height: 6.0,),
                      Text("Hi there, " , style: TextStyle(fontSize: 12.0), ),
                      Text("Where to ? " , style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"), ),
                      
                      SizedBox(height: 20.0,),

                      GestureDetector(
                        onTap: () async {

                          var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen() ));

                          if(res == "obtainDirection"){

                            displayRideDetailsContainer();
                          }

                        },
                        child: Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                        BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.blueAccent, ),
                                SizedBox(width: 10.0 ),
                                Text("Search Dorp Off Location"),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.0,),

                      Row(
                        children: [
                          Icon( Icons.home, color: Colors.grey ),
                          SizedBox(width: 12.0,),
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Provider.of<AppData>(context).pickUpLcation != null
                                ? Provider.of<AppData>(context).pickUpLcation.placeName
                                : "Add Home"
                              ),
                              SizedBox(height: 4.0 ),
                              Text("Your Living home addres", style: TextStyle(color: Colors.black54, fontSize: 12.0 ),)
                            ],
                          )
                        ],
                      ),

                      SizedBox(height: 10.0,),

                      DividerWidget(),

                      SizedBox(height: 10.0,),

                      Row(
                        children: [
                          Icon( Icons.work, color: Colors.grey ),
                          SizedBox(width: 12.0,),
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(height: 4.0 ),
                              Text("Your Office addres", style: TextStyle(color: Colors.black54, fontSize: 12.0 ),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              
              child: Container(

                height: rideDatailsContainerHeight,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight:Radius.circular(16),  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ]
                ),
                
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0 ),
                          child: Row (
                            children: [
                              Image.asset("images/taxi.png", height: 70.0, width: 80.0,),
                              SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Car", style: TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                                  ),
                                  Text(
                                   ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : '') , style: TextStyle(fontSize: 16.0,color: Colors.grey ),
                                  ),
                                  
                                ],
                              ),
                              Expanded(child: Container(),),
                                  Text(
                                    ((tripDirectionDetails != null ) ? '\$${AssistantMethods.colculateFares(tripDirectionDetails)}' : "" ), style: TextStyle(fontFamily: "Brand-Bold" ),
                                  )
                            ],
                          )
                          )
                      ),

                      SizedBox(height: 20.0,),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0 ),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,),
                                    SizedBox(width: 16.0 ),
                                    Text("Cash"),
                                    SizedBox(width: 6.0 ),
                                    Icon(Icons.keyboard_arrow_down, color: Colors.black45 , size: 16.0,)
                                  ],
                                ),
                              ),

                              SizedBox(height: 24.0 ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0 ),
                      child: RaisedButton(
                        onPressed: (){
                          displayRequestRideContainer();
                        },
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Request", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                              Icon(FontAwesomeIcons.taxi, color: Colors.white ,size: 26.0,),
                              ],
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 16.0,
                    color: Colors.black54,
                    offset: Offset(0.7,0.7),
                ) 
                ]
              ),
              height: requestRideContainerHeight,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: 12.0,),
                                  SizedBox(
                    width: double.infinity,
                    child: ColorizeAnimatedTextKit(
                      onTap: () {
                          print("Tap Event");
                        },
                      text: [
                        "Requesting a Ride....",
                        "Please Wait..... ",
                        "Finding a Driver..... ",
                      ],
                      textStyle: TextStyle(
                          fontSize: 55.0,
                          fontFamily: "Signatra"
                      ),
                      colors: [
                        Colors.green,
                        Colors.purple,
                        Colors.pink,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                      textAlign: TextAlign.center,
                      alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
                  ),

                  SizedBox(height: 22.0,),

                  GestureDetector(
                    onTap: (){
                      canceliRideRequest();
                      resetApp();
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(width: 2.0, color: Colors.grey[300] ),
                      ),
                      child: Icon(Icons.close, size: 26.0),
                    ),
                  ),

                  SizedBox(height: 10.0,),

                  Container(
                    width: double.infinity,
                    child: Text("Canncel Ride ", textAlign: TextAlign.center, style: TextStyle( fontSize: 12.0 ),)
                  ),

                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPlaceDrection() async{
    var initialPos = Provider.of<AppData>(context, listen:  false).pickUpLcation;
    var finalPos = Provider.of<AppData>(context, listen:  false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProgressDialog(message: "Please Wait...",);
      },
      );

      var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);
      
      setState(() {
        tripDirectionDetails = details;
      });

      Navigator.pop(context);

      print("This is Encoded Point :: ");
      print(details.encodePoints);

      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolylinePointsResult = polylinePoints.decodePolyline(details.encodePoints);

      pLineCoordinates.clear();

      if(decodedPolylinePointsResult.isNotEmpty){

        decodedPolylinePointsResult.forEach((PointLatLng pointLatLng) { 
          pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude ));
        });
      }

      polylineSet.clear();

      setState(() {
        
        Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
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

      newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70) );

      Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(title: initialPos.placeName, snippet: " My location "),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"),
      );

      Marker dropOfLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: finalPos.placeName, snippet: " DropOff location "),
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

  void initGeofireListner(){

    Geofire.initialize("availableDrivers");
    // Comment
    Geofire.queryAtLocation(currentPosition.latitude,currentPosition.longitude, /*destance to display dirver*/ 15).listen((map) {
        print(map);
        if (map != null) {
          var callBack = map['callBack'];

          //latitude will be retrieved from map['latitude']
          //longitude will be retrieved from map['longitude']

          switch (callBack) {
            case Geofire.onKeyEntered:
            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.nearbyAvailableDriversList.add(nearbyAvailableDrivers);
            if(nearbyAvailableDriverKeysLoaded == true ) {
              updateAvailableDriversOnMap();
            }
              break;

            case Geofire.onKeyExited:
            GeoFireAssistant.removeDriverFromList(map['key']);
            updateAvailableDriversOnMap(); 
              break;

            case Geofire.onKeyMoved:
            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.updateDriverNearbyLocation(nearbyAvailableDrivers);
            updateAvailableDriversOnMap();
              break;

            case Geofire.onGeoQueryReady:
              updateAvailableDriversOnMap();
              break;
          }
        }

        setState(() {});
    });

    // Comment

  }

  void updateAvailableDriversOnMap(){
    setState(() {
      markersSet.clear();
    });

    Set<Marker> tMarkers = Set<Marker>();
    for(NearbyAvailableDrivers driver in GeoFireAssistant.nearbyAvailableDriversList ){
      LatLng driverAvailablePosition = LatLng(driver.latitude, driver.longitude);

      Marker marker = Marker (
        markerId:  MarkerId("driver${driver.key}"),
        position: driverAvailablePosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        rotation: AssistantMethods.createRandomNumber(360),
      );

      tMarkers.add(marker);
    }

    setState(() {
      markersSet = tMarkers; 
    });
  }
}