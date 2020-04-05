import 'package:flutter/material.dart';

import 'package:e_commerce_app/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
      "name": "Heel",
      "picture": "images/products/heel2.jpeg",
      "old_price": 150,
      "price": 100,
    },
    {
      "name": " High Heel",
      "picture": "images/products/heel1.jpeg",
      "old_price": 150,
      "price": 100,
    },
    {
      "name": "Jeans",
      "picture": "images/products/jeans1.jpeg",
      "old_price": 250,
      "price": 150,
    },
    {
      "name": "Jeans",
      "picture": "images/products/jeans2.jpeg",
      "old_price": 250,
      "price": 150,
    },
    {
      "name": "Shoes",
      "picture": "images/products/shoe1.jpeg",
      "old_price": 250,
      "price": 150,
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe2.jpeg",
      "old_price": 250,
      "price": 150,
    },
    {
      "name": "Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 250,
      "price": 150,
    },
    {
      "name": "Dress",
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
            padding: const EdgeInsets.all(10.0),
            child: Single_prod(
              product_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final product_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_prod(
      {this.product_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
