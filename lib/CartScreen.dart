import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget{

  List<String> itemlist;

  CartScreen(this.itemlist);

  @override
  _CartScreenState createState() => _CartScreenState(itemlist);
}

class _CartScreenState extends State<CartScreen> {

  List<String> itemlist;
  _CartScreenState(this.itemlist);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Your Cart",
              style: TextStyle(
                color: Colors.black
              ),
            ),
            Text(itemlist.length.toString() + " items",
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
      body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: itemlist.length,
                    itemBuilder: (_,int index)=>listdataitem(this.itemlist[index]),
                )
            )
          ]
      )
    );
  }
}

class listdataitem extends StatelessWidget{

  String itemname;

  listdataitem(this.itemname);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: new Container(
        child: new Row(
          children: [
            new CircleAvatar(
              child: new Text(itemname[0]),
            ),
            new Text(itemname,
              style: TextStyle(
                fontSize: 20.0
              ),
            )
          ],
        ),
      ),
    );
  }

}