import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class MainPage extends StatelessWidget {
  // String titleInput;
  // String amountInput;
  static const routeName = '/mainpage';

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.amber,
                onPressed: () {
                  DatabaseReference dbref =
                      FirebaseDatabase.instance.reference().child('Test');
                  dbref.set('trogbinhle');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
