import 'package:flutter/material.dart';

class Cart_Product extends StatefulWidget {
  @override
  _Cart_ProductState createState() => _Cart_ProductState();
}

class _Cart_ProductState extends State<Cart_Product> {
  var Products_on_the_cart = [
    {
      "name": " BLack Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": " Blazer",
      "picture": "images/products/blazer2.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe2.jpeg",
      "size": "f",
      "color": "BLack",
      "quantity": 1,
      "price": 150,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_product_name: Products_on_the_cart[index]["name"],
            cart_product_color: Products_on_the_cart[index]['color'],
            cart_product_picture: Products_on_the_cart[index]["picture"],
            cart_product_price: Products_on_the_cart[index]["price"],
            cart_product_quantity: Products_on_the_cart[index]['quantity'],
            cart_product_size: Products_on_the_cart[index]["size"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_product_name;
  final cart_product_picture;
  final cart_product_size;
  final cart_product_price;
  final cart_product_color;
  final cart_product_quantity;

  Single_cart_product(
      {this.cart_product_name,
      this.cart_product_picture,
      this.cart_product_size,
      this.cart_product_price,
      this.cart_product_color,
      this.cart_product_quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: new Image.asset(
            cart_product_picture,
            width: 50.0,
            height: 60.0,
          ),
          title: new Text(cart_product_name),
          subtitle: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: new Text("Size"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: new Text(
                      cart_product_size,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: new Text("Color"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: new Text(
                      cart_product_color,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              new Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  "\$${cart_product_price}",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
//          trailing: new Column(
//            children: <Widget>[
//              new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
//              new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),
//
//
//            ],
//          ),
        ),
      ),
    );
  }
}
