import 'package:flutter/material.dart';
import 'package:e_commerce_app/componets/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        title: Center(child: Text("Shopping Cart",style: TextStyle(color: Colors.black),)),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {}), //iconbutton
        ], //widget
      ), //appbar
      body: new Cart_Product(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text("Total:"),
                subtitle: new Text("\$238"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: new Text(
                  "check out",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
