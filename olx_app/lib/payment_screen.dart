// import 'package:flutter/material.dart';
// import 'package:flutterwave/flutterwave.dart';
// import 'package:olx_app/uploadAddScreen.dart';



// class PaymentScreen extends StatefulWidget {

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {

//   final formKey = GlobalKey<FormState>();
//   final phoneNumberController = TextEditingController();

//   String publicKey = "FLWPUBK-7b01f9ca98be0e0fc4aaf821ba6ff4c4-X";
//   String encryptionKey = "d2b933b57898e55897105a3c";
//   String currency = "FlutterwaveCurrency.GHS,";
//   String amount = "1";

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Make Payment"),
//       ),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//         child: Form(
//           key: this.formKey,
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                 child: Text("Make a payment of "),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 20, 0, 10),

//                 child: Text(" 2 before uploading your item."),
//               ),




//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                 child: Text("with your mobile money number."),
//               ),


//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                 child: TextFormField(
//                   keyboardType: TextInputType.phone,
//                   controller: this.phoneNumberController,
//                   textInputAction: TextInputAction.next,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     hintText: "Mobile Money Number Here",
//                   ),
//                   validator: (value) =>
//                   value.isNotEmpty ? null : "Phone Number is required",
//                 ),
//               ),

//               Container(
//                 width: double.infinity,
//                 height: 50,
//                 margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                 child: RaisedButton(
//                   onPressed: this._makingPayment,
//                   color: Colors.blue,
//                   child: Text(
//                     "Make Payment",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   _makingPayment() {
//     if (this.formKey.currentState.validate()) {
//       this._handlePaymentInitialization();
//       Route newRoute = MaterialPageRoute(builder: (context) => UploadAddScreen());
//       Navigator.pushReplacement(context, newRoute);
//     }
//   }

//   _handlePaymentInitialization() async {
//     final flutterwave = Flutterwave.forUIPayment(
//       amount: amount,
//       currency: currency,
//       context: this.context,
//       publicKey: publicKey,
//       encryptionKey: encryptionKey,
//       email: "winsweba@gmailcom",
//       fullName: "Winchester",
//       txRef: DateTime.now().toIso8601String(),
//       narration: "Example Project",
//       isDebugMode: true,
//       phoneNumber: this.phoneNumberController.text.trim(),
//       acceptAccountPayment: true,
//       acceptCardPayment: false,
//       acceptUSSDPayment: false,
//     );
//     final response = await flutterwave.initializeForUiPayments();
//     if (response != null) {
//       this.showLoading(response.data.status);
//     } else {
//       this.showLoading("No Response!");
//     }
//   }

//   Future<void> showLoading(String message) {
//     return showDialog(
//       context: this.context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Container(
//             margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
//             width: double.infinity,
//             height: 50,
//             child: Text(message),
//           ),
//         );
//       },
//     );
//   }
// }