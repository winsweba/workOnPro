import 'package:barber_booking/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserModels> getUserProfile (String phone) async{
  CollectionReference userRef = FirebaseFirestore.instance.collection("User");
  DocumentSnapshot snapshot = await userRef.doc(phone).get();
  if(snapshot.exists){
    var userModel = UserModels.fromJson(snapshot.data());
    return userModel;
  }
  else return UserModels(); // Empty object
}