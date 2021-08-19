import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userId = "";
String userEmail = "";
String userImage = "";
String getUserName = "";

String addUserName = "";
String addUserImage = "";

String completeAddress = "";
List<Placemark> placemark;
Position position;
