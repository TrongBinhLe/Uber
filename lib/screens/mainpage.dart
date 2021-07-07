import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:uber_now/brand_colors.dart';
import 'package:uber_now/widgets/BrandDevider.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  static const routeName = '/mainpage';
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double searchSheetHeight = (Platform.isIOS) ? 270 : 250;

  double mapBottomPadding = 0;

  Completer<GoogleMapController> _controller = Completer();

  GoogleMapController mapController;
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        drawer: Container(
          width: 250,
          color: Colors.white,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: [
                Container(
                  height: 160,
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/user_icon.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Trong Binh ',
                              style: TextStyle(
                                  fontFamily: 'Brand-Bold', fontSize: 20),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'View Profile',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BranDivider(),
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  leading: Icon(
                    OMIcons.cardGiftcard,
                  ),
                  title: Text(
                    'Free Rides',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  leading: Icon(OMIcons.creditCard),
                  title: Text(
                    'Payments',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    OMIcons.history,
                  ),
                  title: Text(
                    'Ride History',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    OMIcons.contactSupport,
                  ),
                  title: Text(
                    'Support',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    OMIcons.info,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding),
              initialCameraPosition: MainPage._kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                setState(() {
                  mapBottomPadding = 260;
                });
              },
            ),

            // Menu Button
            Positioned(
              top: 50,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  _globalKey.currentState.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 3.0,
                        blurRadius: 3.0,
                        offset: Offset(0.5, 0.5),
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(
                      OMIcons.menu,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            // Search Sheet
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: searchSheetHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                        offset: Offset(5, 5)),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Nice to see you',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Where are you going?',
                        style:
                            TextStyle(fontFamily: 'Brand-Bold', fontSize: 20),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 5.0,
                                blurRadius: 10.0,
                                offset: Offset(3.0, 4.0))
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search Destination',
                                style: TextStyle(fontSize: 15.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            OMIcons.home,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Home',
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Your residential address',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: BrandColors.colorDimText),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      BranDivider(),
                      SizedBox(
                        height: 2.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            OMIcons.workOutline,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Work',
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Your office address',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: BrandColors.colorDimText),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
