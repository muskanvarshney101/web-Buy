import 'package:e_commerce_app/Logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 490.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/fashion.jpg'),
          AssetImage('images/img.jpg'),
          AssetImage('images/img1.jpeg'),
          AssetImage('images/img3.jpeg'),
          AssetImage('images/img4.jpeg'),
          AssetImage('images/img5.jpeg'),
          AssetImage('images/img6.jpeg'),
          AssetImage('images/img7.jpeg'),
        ],
        autoplay: false,
//        animationCurve: Curves.fastOutSlowIn,
//        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
//          dotColor: Colors.red,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
        body: Stack(
      children: <Widget>[

        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 35, right: 35.0, top: 100.0, bottom: 0.0),
              child: Container(
                child: image_carousel,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 55.0, left: 15.0, right: 15.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.pink,
                elevation: 0.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => new Start()));
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text(
                    " Getting Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ),

          ],
        ),
      ],
    ));
  }
}
