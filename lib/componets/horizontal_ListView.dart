import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/cat/accessories.png',
            image_caption: 'accessories',
          ),
          Category(
            image_location: 'images/cat/dress.png',
            image_caption: 'Dress',
          ),
          Category(
            image_location: 'images/cat/formal-shirt.png',
            image_caption: 'Formal',
          ),
          Category(
            image_location: 'images/cat/informal.png',
            image_caption: 'Informal',
          ),
          Category(
            image_location: 'images/cat/jeans.jpeg',
            image_caption: 'jeans',
          ),
          Category(
            image_location: 'images/cat/shoe.png',
            image_caption: 'shoe',
          ),
          Category(
            image_location: 'images/cat/tshirt.png',
            image_caption: 'T-shirt',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 90.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 20,
              height: 50.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                image_caption,
                style: new TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
