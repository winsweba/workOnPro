import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/addon_model.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

double foodDetailImageAreaSize(BuildContext context) {
  return MediaQuery.of(context).size.height / 3;
}

double calculateFinalPayment(double subTotal, double discount) {
  return subTotal - (subTotal * (discount / 100));
}

int createOrderNumber(int original) {
  return original + new Random().nextInt(1000);
}

String converToDate(int date) => DateFormat('dd-MM-yyyy HH:mm')
    .format(DateTime.fromMillisecondsSinceEpoch(date));

String converToStatus(int status) => status == 0
    ? 'Placed'
    : status == 1
        ? 'Shipping'
        : status == 2
            ? 'Shipped'
            : 'Cancelled';

MaterialColor convertStatusToColor(int orderStatus) => orderStatus == -1
    ? Colors.red
    : orderStatus == 0
        ? Colors.blue
        : orderStatus == 1
            ? Colors.yellow
            : Colors.green;

String convertAddonToText(List<AddonModel> addon) {
  var result = '';
  addon.map((e) => result+="${e.name},");
  return result.length > 0 ? result.substring(0, result.length -1) : result;  
}