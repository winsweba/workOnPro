import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

double foodDetailImageAreaSize(BuildContext context){
  return MediaQuery.of(context).size.height /3;
}

double calculateFinalPayment (double subTotal, double discount ){
  return subTotal - (subTotal*(discount/100) );
}
int createOrderNumber (int original){
  return original + new Random().nextInt(1000);
}

