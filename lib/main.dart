import 'package:flutter/material.dart';

import 'Login.dart';

void main() {
  runApp(HelpingHands());
}

class HelpingHands extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Helping Hands",
      theme: ThemeData(
          primarySwatch: Colors.indigo
      ),
      home: LoginScreen(),
    );
  }

}
