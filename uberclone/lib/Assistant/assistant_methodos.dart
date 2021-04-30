import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uberclone/Assistant/request_assistant.dart';
import 'package:uberclone/DataHandler/app_data.dart';
import 'package:uberclone/configMaps.dart';
import 'package:uberclone/models/address.dart';

class AssistantMethods{
  static Future<String> searchCoordinateAddress( Position position, context ) async{

    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed" ){
      
      //placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      // st3 = response["results"][0]["address_components"][5]["long_name"];
      // st4 = response["results"][0]["address_components"][6]["long_name"];
      // placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4 ;
      placeAddress = st1 + ", " + st2;

      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false ).updatePickUpLcationAddress(userPickUpAddress);
    }

    return placeAddress;
  }
}