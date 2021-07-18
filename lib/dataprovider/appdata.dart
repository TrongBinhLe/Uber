import 'package:flutter/material.dart';
import 'package:uber_now/datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address pickupAdress;
  void updatePickupAdress(Address pickup) {
    pickupAdress = pickup;
    notifyListeners();
  }
}
