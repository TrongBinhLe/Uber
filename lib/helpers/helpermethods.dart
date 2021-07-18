import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_now/datamodels/address.dart';
import 'package:uber_now/dataprovider/appdata.dart';
import 'package:uber_now/globalvariable.dart';
import 'package:uber_now/helpers/requesthelper.dart';
import 'package:provider/provider.dart';

class HelperMethods {
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
}
