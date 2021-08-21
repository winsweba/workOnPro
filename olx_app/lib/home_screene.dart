import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olx_app/Welcome/welcome_screen.dart';
import 'package:olx_app/global_avaribles.dart';
import 'package:olx_app/uploadAddScreen.dart';

class HomeScreene extends StatefulWidget {

  @override
  _HomeScreeneState createState() => _HomeScreeneState();
}

class _HomeScreeneState extends State<HomeScreene> {
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
    void initState() {
      // TODO: implement initState
      super.initState();
      getUserAddress();
    }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
    _screenHeight = MediaQuery.of(context).size.height;

    Widget showItemList() {
      
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