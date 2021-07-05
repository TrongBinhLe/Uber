import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:uber_now/screens/mainpage.dart';
import 'package:uber_now/widgets/progressDialog.dart';

import '../brand_colors.dart';
import './registrationpage.dart';
import '../widgets/taxibutton.dart';

class Loginpage extends StatefulWidget {
  static const String routeName = '\login_page';

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();
  var passController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackbar(String title) {
    final snackBar = new SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    // scaffoldKey.currentState.showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void login() async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Loggin you in',
            ),
        barrierDismissible: false);

    final FirebaseUser user = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passController.text)
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackbar(thisEx.message);
    }))
        .user;
    if (user != null) {
      // verify login
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) => {
            if (snapshot.value != null)
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainPage.routeName, (route) => false)
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 70,
                ),
                Image(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: 100.0,
                  image: AssetImage('images/logo.png'),
                ),
                Text(
                  'Sign In as a Rider',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TaxiButton(
                        title: 'LOGIN',
                        color: BrandColors.colorGreen,
                        onPress: () async {
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackbar('No internet connectivity');
                            return;
                          }

                          if (!emailController.text.contains('@')) {
                            showSnackbar('Please enter a valid email address');
                            return;
                          }
                          if (passController.text.length < 8) {
                            showSnackbar('Please enter a valid password');
                            return;
                          }

                          login();
                        },
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        RegistrationPage.routeName, (route) => false);
                  },
                  child: Text('Don\'t have an account, sign up here.'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
