import 'package:food_ordering_app/models/cart_model.dart';

class OrderModel{
  String userId = '',
  userName = '',
  userPhone = '',
  shippingAddress = '',
  comment = '',
  orderNumber = '',
  restaurantId = '';
  double totalPayment = 0, finalPayment = 0, shippingCost = 0, discount = 0;
  bool isCod = false;
  List<CartModel> cartItemList = List<CartModel>.empty(growable: true);
  int orderStatus = 0, createdDate = 0;

  OrderModel(
    this.cartItemList,
    this.comment,
    this.createdDate,
    this.discount,
    this.finalPayment,
    this.isCod,
    this.orderNumber,
    this.orderStatus,
    this.shippingAddress,
    this.shippingCost,
    this.totalPayment,
    this.userId,
    this.userName,
    this.userPhone,
    this.restaurantId
  );

  OrderModel.fromJson(Map<String, dynamic> json )
  {
    userId = json['userId'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    restaurantId= json['restaurantId'];
    shippingAddress = json['shippingAddress'];
    comment = json['comment'];
    orderNumber = json['orderNumber'];
    totalPayment = double.parse(json['totalPayment']);
    finalPayment = double.parse(json['finalPayment']);
    shippingCost = double.parse(json['shippingCost']);
    isCod = json['isCod'] as bool;
    orderStatus = int.parse(json['orderStatus']);
    if(json['cartItemList'] != null ){
      json['cartItemList'].forEach((v) {
        cartItemList.add(CartModel.fromJson(v));
      } );
    }

    Map<String, dynamic > toJson(){
      final data = Map<String, dynamic>();
      data['serId'] = this.userId;
      data['userPhone'] = this.userPhone;
      data['userName'] = this.userName;
      data['shippingAddress'] = this.shippingAddress;
      data['comment'] = this.comment;
      data['orderNumber'] = this.orderNumber;
      data['totalPayment'] = this.totalPayment;
      data['shippingCost'] = this.shippingCost;
      data['discount'] = this.discount;
      data['isCod'] = this.isCod;
      data['orderStatus'] = this.orderStatus;
      data['cartItemList'] = this.cartItemList;
      data['restaurantId'] = this.restaurantId;

      return data;
    }
  }
}