import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_now/brand_colors.dart';
import 'package:uber_now/datamodels/prediction.dart';
import 'package:uber_now/dataprovider/appdata.dart';
import 'package:uber_now/globalvariable.dart';
import 'package:uber_now/helpers/requesthelper.dart';
import 'package:uber_now/widgets/BrandDevider.dart';
import 'package:uber_now/widgets/PredictionTitle.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search_page';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  FocusNode focusDestination;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusDestination = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusDestination.dispose();
    super.dispose();
  }

  List<Prediction> destinationPredictionList = [];

  void searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$keyMap&sessiontoken=1234567890';
      var response = await RequestHelper.getRequest(url);

      if (response == 'failed') {
        return;
      }
      if (response['status'] == 'OVER_QUERY_LIMIT') {
        print('display notify screen with message---Over-query-limit----');
      } else if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];

        var thisList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();

        setState(() {
          destinationPredictionList = thisList;
        });
        print(response);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String address;
    Provider.of<AppData>(context).pickupAdress != null
        ? address = Provider.of<AppData>(context).pickupAdress.placeName
        : address = '';
    pickupController.text = address;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 40,
                  right: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        Center(
                          child: Text(
                            'Set Destination',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Brand-Bold'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'images/pickicon.png',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGray,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: TextField(
                                controller: pickupController,
                                decoration: InputDecoration(
                                  hintText: 'Pick Location',
                                  fillColor: BrandColors.colorLightGrayFair,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'images/desticon.png',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: BrandColors.colorLightGray,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: TextField(
                                autofocus: true,
                                focusNode: focusDestination,
                                onChanged: (value) {
                                  searchPlace(value);
                                },
                                controller: destinationController,
                                decoration: InputDecoration(
                                  hintText: 'Where to ?',
                                  fillColor: BrandColors.colorLightGrayFair,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 10,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            (destinationPredictionList.length > 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return PredicitonTitle(
                          prediction: destinationPredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return BranDivider();
                      },
                      itemCount: destinationPredictionList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
