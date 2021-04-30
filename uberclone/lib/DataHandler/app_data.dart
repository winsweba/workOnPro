import 'package:flutter/foundation.dart';
import 'package:uberclone/models/address.dart';

class AppData extends ChangeNotifier{
  
  Address pickUpLcation;

  void updatePickUpLcationAddress(Address pickUpAddress){
    pickUpLcation = pickUpAddress;
    notifyListeners();
  }
}