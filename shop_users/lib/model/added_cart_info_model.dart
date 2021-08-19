import 'package:cloud_firestore/cloud_firestore.dart';

class AddedCartInfoModel {
  final String id;
  final String userId;
  final String title;
  final String imgUrl;
  final double price;
  final Timestamp timestamp;

  AddedCartInfoModel(
      {this.id, 
      this.title,
      this.imgUrl, 
      this.price,
      this.userId,
      this.timestamp
      }
      );

  factory AddedCartInfoModel.fromJson(Map<String, dynamic> json){
    return AddedCartInfoModel(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      title: json['title'].toString(),
      imgUrl: json['imgUrl'].toString(),
      price: double.parse(json['price']),
      timestamp: json['timestamp'],
    );
  }
  AddedCartInfoModel.fromFirestore(Map<String,dynamic> firestore )
  : imgUrl = firestore['imgUrl'],
  title = firestore['title'],
  price = double.parse(firestore['price'].toString()),
  id = firestore['id'],
  userId = firestore['userId'],
  timestamp = firestore['timestamp'];
}
