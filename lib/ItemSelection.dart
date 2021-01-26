import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import "package:url_launcher/url_launcher.dart";

import 'CartScreen.dart';
import 'GetItem.dart';

class ItemSelection extends StatefulWidget{

  @override
  _ItemSelectionState createState() => _ItemSelectionState();
}



class _ItemSelectionState extends State<ItemSelection> {

  TextEditingController itemselected = TextEditingController();
  String selecteditem;
  Future<List<String>> _future;
  List<String> addeditems = ["Welcome"];

  @override
  void initState() {
    _future = getitem();
    super.initState();
  }


  int counter = 0;
  int counter_cart = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
                child: Text('Privacy Policy'),
                onTap: () => launch('https://www.openeyessurveys.com/privacy-policy')
            ),
            Container(
                height: 20,
                child: VerticalDivider(
                    thickness: 1,
                    color: Colors.black
                )
            ),
            SizedBox(width: 3,),
            InkWell(
                child: Text('Terms of Use'),
                onTap: () => launch('https://www.openeyessurveys.com/terms-of-use')
            ),
          ],
        ),
        Text('© 2020 & powered by OpenEyes Technologies Inc.'),
      ],
      appBar: AppBar(
        title: Text("Helping Hands"),
        centerTitle: true,
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(
                icon: Icon(
                  Icons.notifications
                ),
                onPressed: () {
                  // do something
                  setState(() {
                    counter = 0;
                  });
                },
              ),
              counter != 0 ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ): new Container()
            ],
          ),
          new Stack(
            children: <Widget>[
              new IconButton(
                icon: Icon(
                    Icons.shopping_cart
                ),
                onPressed: () {
                  // do something
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen(items)));
                  setState(() {
                    counter_cart = 0;
                  });
                },
              ),
              counter_cart != 0 ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ): new Container()
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Increment Counter");
          setState(() {
            counter++;
          });
        },child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome to Helping Hands",
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder(
              future: _future,
              builder: (context, AsyncSnapshot<List<String>> snapshot){
                return dropdown(snapshot);
              }
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(onPressed: (){
              if(itemselected.text.isEmpty){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Please choose an item first"),
                ));
              }
              else {
                print(itemselected.text);
                addeditems.add(itemselected.text);
              }
            },
              child: Text(
                "Add to Cart",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white
                ),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0
              ),
              color: Colors.lightBlue[900],
            )
          ],
        ),
      ),
    );
  }

 Widget dropdown(AsyncSnapshot<List<String>> snapshot) {
   switch (snapshot.connectionState) {
     case ConnectionState.none:
       return Text('none');
     case ConnectionState.waiting:
       return Center(child: CircularProgressIndicator());
     case ConnectionState.active:
       return Text('');
     case ConnectionState.done:
       if (snapshot.hasError) {
         return Text(
           '${snapshot.error}',
           style: TextStyle(color: Colors.red),
         );
       } else {
         return DropDownField(
             controller: itemselected,
             hintText: "Select an item",
             enabled: true,
             itemsVisibleInDropdown: 5,
             items: snapshot.data,
             onValueChanged: (dynamic value) {
               setState(() {
                 selecteditem = value;
               });
             });
       }
   }
  }
}

final List<String> items = [];
Future<List<String>> getitem() async {
  var response = await http.get(
      "https://sheet.best/api/sheets/00f2c956-1c25-44ab-85f5-2e3bcfc580a0",
      headers: {
        "Accept": "application/json"
      }
  );
  // ignore: unrelated_type_equality_checks
  if(response.statusCode == 200){
    List<GetItem> getitem = getItemFromJson(response.body);
    print(getitem.length);

    for (int i = 0; i < getitem.length; i++) {
      items.add(getitem[i].itemName);
    }
  }

  return items;
}



/*
final cityselected = TextEditingController();
String selectedcity = "";
List<String> cities = [
  "Mumbai",
  "Matunga",
  "Coimbatore",
  "Chennai",
  "Delhi",
  "Dehra",
  "Washington",
  "Heaven",
  "Hell"
];*/
