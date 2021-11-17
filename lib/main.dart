import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_now/dataprovider/appdata.dart';
import 'package:uber_now/screens/searchpage.dart';
import './screens/mainpage.dart';
import './screens/registrationpage.dart';
import './screens/loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
            fontFamily: 'Brand-Regular', primaryColor: Colors.deepPurpleAccent),
        initialRoute: Loginpage.routeName,
        routes: {
          SearchPage.routeName: (context) => SearchPage(),
          MainPage.routeName: (context) => MainPage(),
          Loginpage.routeName: (context) => Loginpage(),
          RegistrationPage.routeName: (context) => RegistrationPage(),
        },
      ),
    );
  }
}
