import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_now/datamodels/address.dart';
import 'package:uber_now/datamodels/directiondetails.dart';
import 'package:uber_now/datamodels/user.dart';
import 'package:uber_now/dataprovider/appdata.dart';
import 'package:uber_now/globalvariable.dart';
import 'package:uber_now/helpers/requesthelper.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  static void getCurrentUserInfo() async {
    currentFirebaseUser = await FirebaseAuth.instance.currentUser();
    String uid = currentFirebaseUser.uid;

    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$uid');

    userRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        currentUserInfo = User.fromSnapShot(snapshot);
        print('my name is ${currentUserInfo.fullName}');
      }
    });
  }

  static Future<String> findCordinateAddress(Position position, context) async {
    String placeAddress = '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$keyMap';

    var response = await RequestHelper.getRequest(url);
    if (response != 'failed') {
      var results;
      results = response['results'];
      if (results != null) {}
      placeAddress = response['results'][0]['formatted_address'];

      Address pickupAdress = new Address();

      pickupAdress.latitude = position.latitude;
      pickupAdress.longitude = position.longitude;
      pickupAdress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupAdress(pickupAdress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$keyMap';

    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return null;
    }
    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['duration']['value'];
    directionDetails.encodePoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static int estimateFares(DirectionDetails details) {
    // per km : 0.3$
    // per minute : 0.2$
    // pase fare :$3

    double baseFare = 3;
    double distanceFare = (details.distanceValue / 1000) * 0.3;
    double timeFare = (details.durationValue / 60) * 0.2;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }
}
