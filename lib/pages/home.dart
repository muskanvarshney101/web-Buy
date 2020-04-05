import 'dart:developer';

import 'package:e_commerce_app/pages/login.dart';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';

//my own imports
import 'package:e_commerce_app/componets/horizontal_ListView.dart';
import 'package:e_commerce_app/componets/product.dart';
import 'package:e_commerce_app/pages/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  TextEditingController __searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 190.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/img.jpg'),
          AssetImage('images/img1.jpeg'),
          AssetImage('images/img2.jpeg'),
          AssetImage('images/img3.jpeg'),
          AssetImage('images/img4.jpeg'),
          AssetImage('images/img5.jpeg'),
        ],
        autoplay: true,
//        animationCurve: Curves.fastOutSlowIn,
//        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
//          dotColor: Colors.red,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.pink),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Material(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[100],
            elevation: 0.0,
            child: TextFormField(
              controller: __searchController,
              decoration: InputDecoration(
                  hintText: " Search...",
                  icon: Icon(Icons.search),
                  border: InputBorder.none),
              validator: (value) {
                if (value.isEmpty) {
                  return "Search can not be empty";
                }
                return null;
              },
            ),
          ),

          actions: <Widget>[

            new IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.pink,
                ),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new Cart()));
                })
          ]), //Appbar

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header
            new UserAccountsDrawerHeader(
              accountName: Text('Muskan varshney',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic)),
              accountEmail: Text('Muskan.varshney123@gmail.com',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic)),
              decoration: BoxDecoration(color: Colors.white),
              currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              )),
            ), //userAccountDrawerHeader

            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>new HomePage()));
              },
              child: ListTile(
                title: Text('Home'),
                leading: Icon(
                  Icons.home,

                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('my account'),
                leading: Icon(
                  Icons.account_circle,

                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My orders'),
                leading: Icon(
                  Icons.shopping_basket,

                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Cart()));
              },
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(
                  Icons.dashboard,

                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,

                ),
              ),
            ), //inwell




            InkWell(
              onTap: () async {
                await signout();

              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(
                  Icons.transit_enterexit,
                ),
              ),
            ),
          ], //widget
        ), //ListView
      ),

      body: new Column(
        children: <Widget>[
          image_carousel,
//          new Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Container(
//              alignment: Alignment.centerLeft,
//              child: Text(
//                "Categories",
//              ),
//            ),
//          ),
//
//          //Horizontal list view begin here
//          HorizontalList(),

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Products",
                  ),
                ),
              ),
            ],
          ),
          //grid view
          Flexible(child: Products())
        ],
      ),
    ); //Scaffold
  }

  Future signout() async {
   await firebaseAuth.signOut();
    await googleSignIn.signOut();
   Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context) => new Login()));
    Fluttertoast.showToast(msg: 'Logout');
  }
}
