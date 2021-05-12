import 'package:flutter/foundation.dart';
import 'package:uberclone/models/address.dart';

class AppData extends ChangeNotifier{
  
  Address pickUpLcation, dropOffLocation;

  void updatePickUpLcationAddress(Address pickUpAddress){
    pickUpLcation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLcationAddress(Address dropOffAddress){
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

}