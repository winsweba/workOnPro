import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop_users/model/added_cart_info_model.dart';
import 'package:shop_users/model/cart_item.dart';

Future<void> userSetup(String email) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.add({'email': email, 'uid': uid});
  return;
}

Future<void> buyInfo(
  String imgUrl,
  String phoneNumber,
  String location,
  String title,
  String totalPrice,
  /*//TODO Add  this*/
) async {
  DocumentReference buyReference =
      FirebaseFirestore.instance.collection('buy').doc();
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  buyReference.set({
    'imgUrl': imgUrl,
    'phoneNumber': phoneNumber,
    'location': location,
    'title': title,
    //TODO Add  this
    'totalPrice': totalPrice,
    'itemId': buyReference.id,
    'userId': uid,
    'timestamp': FieldValue.serverTimestamp()
  });
  return;
}

Future<void> addToCartInfo(
  double price, String imgUrl, String title /*//TODO Add  this*/) async {
  DocumentReference addToCartReference =
      FirebaseFirestore.instance.collection('cart').doc();
  // addToCartReference.get();
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  addToCartReference.set({
    'userId': uid,
    'title': title,
    'imgUrl': imgUrl,
    'price': price,
    'id': addToCartReference.id,
    'timestamp': FieldValue.serverTimestamp()
  });
  return;
}

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;


  Stream<List<CartItem>> fetchUpcomingProduct() {
    return _db.collection('items').snapshots().map((query) => query.docs).map(
          (snapshot) => snapshot
              .map(
                (doc) => CartItem.fromFirestore(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<AddedCartInfoModel>> fetchUpcomingProductToCart(String userId ) {
    return _db
    .collection('cart')
    .where('userId', isEqualTo: userId)
    .snapshots().map((query) => query.docs).map(
          (snapshot) => snapshot
              .map(
                (doc) => AddedCartInfoModel.fromFirestore(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}
