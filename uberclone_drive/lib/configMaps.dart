import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uberclone_drive/models/all_users.dart';

String mapKey = "API_KEY";

User firebaseUser;

Users usersCurrentInfo;

User currentFirebaseUser;

StreamSubscription<Position> homeTabPageStreamSubscription;