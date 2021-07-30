import 'package:flutter/material.dart';
import 'package:uber_now/datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address pickupAdress;
  Address destinationAdress;
  void updatePickupAdress(Address pickup) {
    pickupAdress = pickup;
    notifyListeners();
  }

  void updateDestinationAdress(Address destination) {
    destinationAdress = destination;
    notifyListeners();
  }
}
