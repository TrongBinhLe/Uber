import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:uber_now/brand_colors.dart';
import 'package:uber_now/datamodels/address.dart';
import 'package:uber_now/datamodels/prediction.dart';
import 'package:uber_now/dataprovider/appdata.dart';
import 'package:uber_now/globalvariable.dart';
import 'package:uber_now/helpers/requesthelper.dart';
import 'package:uber_now/widgets/progressDialog.dart';

class PredicitonTitle extends StatelessWidget {
  final Prediction prediction;

  void getPlaceDetails(context, placeID) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Please waiting...',
      ),
      barrierDismissible: true,
    );

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$keyMap';

    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return;
    }
    if (response['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = response['result']['geometry']['location']['lat'];
      thisPlace.latitude = response['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false)
          .updateDestinationAdress(thisPlace);
      print(thisPlace.placeName);
    }
  }

  PredicitonTitle({this.prediction});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        getPlaceDetails(context, prediction.placeId);
      },
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                OMIcons.locationOn,
                color: BrandColors.colorDimText,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prediction.mainText,
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      prediction.secondaryText,
                      style: TextStyle(
                          fontSize: 12, color: BrandColors.colorDimText),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
