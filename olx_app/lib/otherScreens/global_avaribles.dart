import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userId = "";
String userEmail = "";
String userImageUrl = "";
String getUserName = "";

String addUserName = "";
String addUserImage = "";

String completeAddress = "";
List<Placemark> placemarks;
Position position;
