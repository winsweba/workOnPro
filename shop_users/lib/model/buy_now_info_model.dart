class BuyNowInfoModel {
  final String location;
  final String phoneNumber;
  final String imgUrl;
  final String title;
  final double totalPrice;
  final double itemId;
  final String timestamp;

  BuyNowInfoModel(
      {this.location,
      this.phoneNumber,
      this.imgUrl,
      this.title,
      this.totalPrice,
      this.timestamp,
      this.itemId}
      );

  factory BuyNowInfoModel.fromJson(Map<String, dynamic> json){
    return BuyNowInfoModel(
      location: json['location'].toString(),
      phoneNumber: json['phoneNumber'].toString(),
      title: json['title'].toString(),
      //TODO Add  this
      imgUrl: json['imgUrl'].toString(),
      totalPrice: json['totalPrice'],
      timestamp: json['timestamp'].toString(),
      itemId:json['itemId']
    );
  }
}
