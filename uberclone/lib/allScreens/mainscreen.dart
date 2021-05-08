import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uberclone/Assistant/assistant_methodos.dart';
import 'package:uberclone/DataHandler/app_data.dart';
import 'package:uberclone/allScreens/search_screen.dart';
import 'package:uberclone/allWidget/divider.dart';
import 'package:uberclone/allWidget/progress_dialog.dart';

class MainScreen extends StatefulWidget {
  
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin  {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDatailsContainerHeight = 0;
  double seachContainerHeight = 300.0;

  void displayRideDetailsContainer() async {
    await getPlaceDrection();

    setState((){

      seachContainerHeight = 0.0;
      rideDatailsContainerHeight = 240.0;
      bottomPaddingOfMap = 230.0;
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
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: (){
                
                scaffoldKey.currentState.openDrawer();

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
                  child: Icon(Icons.menu, color: Colors.black , ),
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
                                    "10km", style: TextStyle(fontSize: 16.0,color: Colors.grey ),
                                  )
                                ],
                              ),

                              SizedBox(height: 20.0,),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0 ),
                                child: Row(
                                  children: [
                                    Icon(FontAwesome.moneyCheckAlt, size: 18.0, color: Colors.black54,),
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
                                    print("Clicked");
                                  },
                                  color: Theme.of(context).accentColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(17.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Request", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                                        //Icon(FontAwesome.taxi, color: Colors.white ,size: 26.0,),
                                      ],
                                    ),
                                  )
                                ),
                              ),

                            ],
                          )
                          )
                      )
                    ],
                  ),
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
}