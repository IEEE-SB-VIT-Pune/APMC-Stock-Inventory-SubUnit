import 'package:flutter/material.dart';

class Transactions{
  String customerName, phoneNumber, paymentMode,occupation;
  var time, items;

  Transactions(this.customerName, @required this.paymentMode, this.phoneNumber, this.time, this.items,this.occupation);
}