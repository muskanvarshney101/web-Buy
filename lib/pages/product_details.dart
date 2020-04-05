import 'package:flutter/material.dart';
import 'home.dart';

class ProductDetails extends StatefulWidget {
  final product_details_name;
  final product_details_new_price;
  final product_details_old_price;
  final product_details_picture;

  ProductDetails(
      {this.product_details_name,
      this.product_details_new_price,
      this.product_details_old_price,
      this.product_details_picture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new HomePage()));
            },
            child: Center(child: Text("Web-Buy",textAlign: TextAlign.center,style: TextStyle(color: Colors.black),))),
        actions: <Widget>[
      new IconButton(
      icon: Icon(
        Icons.add_shopping_cart,
        color: Colors.black,
      ),
        onPressed: () {}), //iconbutton

          new IconButton(
              icon: Icon(Icons.favorite_border),
              color: Colors.black,
              onPressed: () {})
        ], //widget
      ), //appbar
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          children: <Widget>[
            new Container(
              height: 290.0,
              child: GridTile(
                child: Container(
                  color: Colors.white70,
                  child: Image.asset(widget.product_details_picture),
                ), //container
                footer: new Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      widget.product_details_name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    title: new Row(
                      children: <Widget>[
                        Expanded(
                          child: new Text(
                            "\$${widget.product_details_old_price}",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Expanded(
                          child: new Text(
                            "\$${widget.product_details_new_price}",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Size"),
                              content: new Text("Choose the size"),
                              actions: <Widget>[
                                new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text(
                                    "close",
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: new Text("Size")),
                        Expanded(
                          child: new Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Color"),
                              content: new Text("Choose the color"),
                              actions: <Widget>[
                                new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text("close"),
                                )
                              ],
                            );
                          });
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: new Text("Color")),
                        Expanded(
                          child: new Icon(Icons.arrow_drop_down),
                        ), //Expanded
                      ], //Widget
                    ), //Row
                  ), //MaterialButton
                ), //Expanded
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return new AlertDialog(
                              title: new Text("Quantity"),
                              content: new Text("Choose the Qty"),
                              actions: <Widget>[
                                new MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: new Text("close"),
                                )
                              ],
                            );
                          });
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    elevation: 0.2,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: new Text("Qty")),
                        Expanded(
                          child: new Icon(Icons.arrow_drop_down),
                        ), //Expanded
                      ], //widget
                    ), //Row
                  ), //MaterialButton
                ), //Expanded
              ], //Widget
            ), //Row
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.blueGrey[100],
                      textColor: Colors.blue,
                      elevation: 0.2,
                      child: Text("Buy now",style: TextStyle(color: Colors.black,)), //Row
                    ),
                  ), //MaterialButton
                ), //Expanded


              ], //Widget
            ), //Row
            new ListTile(
              title: new Text("Product Details",style: TextStyle(fontWeight: FontWeight.w500),),
              subtitle: Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Text(
                    "Lorem ipsum, or lipsum as it is sometimes known, is dummy text "
                    "used in laying out print, graphic or web designs. The passage is attributed to an"
                    " unknown typesetter in the 15th century who is thought to have scrambled parts of "
                    "Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12),),
              ),
            ),
            Divider(),
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text(
                    "Product name :",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text(widget.product_details_name,style: TextStyle(fontStyle: FontStyle.italic),),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text(
                    "Product brand :",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text("brand X ",style: TextStyle(fontStyle: FontStyle.italic)),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text(
                    "Product condition :",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Text("NEW",style: TextStyle(fontStyle: FontStyle.italic)),
                )
              ],
            ),
            Divider(),
            new Text("Simliar Products",style: TextStyle(fontWeight: FontWeight.w500)),
            Container(
              height: 340.0,
              child: Similar_Product(),
            )
          ], //Widget.
        ),
      ), //ListView
    ); //Scaffold
  }
}

class Similar_Product extends StatefulWidget {
  @override
  _Similar_ProductState createState() => _Similar_ProductState();
}

class _Similar_ProductState extends State<Similar_Product> {
  var product_list = [
    {
      "name": " BLack Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "images/products/dress 2.jpg",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 250,
      "price": 150,
    },
    {
      "name": "Black Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 250,
      "price": 150,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Similar_Single_prod(
              product_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Similar_Single_prod extends StatelessWidget {
  final product_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_Single_prod(
      {this.product_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Hero(
          tag: new Text("hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        product_details_name: product_name,
                        product_details_new_price: prod_price,
                        product_details_old_price: prod_old_price,
                        product_details_picture: prod_picture,
                      ))),
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    title: Text(product_name,style:TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold),),
                    trailing: Text("\$$prod_price",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w800,fontSize: 15.0),),
                  ),
                ),
                child: Image.asset(
                  prod_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
