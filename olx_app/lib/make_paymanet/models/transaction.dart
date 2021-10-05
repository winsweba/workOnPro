
import 'package:flutter/material.dart';
import 'package:olx_app/make_paymanet/models/transaction_status.dart';
import 'package:olx_app/otherScreens/uploadAddScreen.dart';

import 'api_response.dart';

class Transaction {
  String message;
  String refrenceNumber;
  TransactionState state;

  Transaction({
    this.message,
    this.refrenceNumber,
    this.state,
  });

  factory Transaction.fromObject(APIResponse apiResponse, /* BuildContext context */) {
    final transaction = Transaction();
    transaction.message =
        apiResponse.gatewayResponse ?? apiResponse.dataMessage ?? "";
    transaction.refrenceNumber = apiResponse.reference;
    transaction.state = apiResponse.nextAction;


    // Route newRoute = MaterialPageRoute(builder: (context) => UploadAddScreen());
    //                 Navigator.pushReplacement(context, newRoute);
    return transaction;
  }
}
