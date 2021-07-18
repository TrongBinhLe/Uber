import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_now/brand_colors.dart';
import 'package:uber_now/dataprovider/appdata.dart';

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

  @override
  Widget build(BuildContext context) {
    String address;
    Provider.of<AppData>(context).pickupAdress != null
        ? address = Provider.of<AppData>(context).pickupAdress.placeId
        : address = '';
    pickupController.text = address;

    return Scaffold(
      body: Column(
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
              padding:
                  EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 40),
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
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
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
                              focusNode: focusDestination,
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
        ],
      ),
    );
  }
}
