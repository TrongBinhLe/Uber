import 'package:flutter/material.dart';

class TaxiButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPress;

  TaxiButton({this.title, this.color, this.onPress});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0, fontFamily: 'Brand-Bold'),
          ),
        ),
      ),
      color: color,
      textColor: Colors.white,
      onPressed: onPress,
    );
  }
}
