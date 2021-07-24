import 'package:barber_booking/models/city_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<CityModels>> getCities() async {
  var cities = new List<CityModels>.empty(growable: true);
  var cityRef = FirebaseFirestore.instance.collection("AllSalon");
  var snapshot = await cityRef.get();
  snapshot.docs.forEach((element) { 
    cities.add(CityModels.fromJson(element.data()));
  });

  return cities;

}