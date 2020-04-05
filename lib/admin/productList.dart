import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product_List extends StatefulWidget {
  @override
  _Product_ListState createState() => _Product_ListState();
}

class _Product_ListState extends State<Product_List> {
  Firestore firestore =Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Product List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                    title: Text('name',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: PopupMenuButton<String>(
                      itemBuilder: (context) => <PopupMenuItem<String>>[
                        PopupMenuItem<String>(
                          value: 'one',
                          child: Text('Delete'),
                        )
                      ],
                      onSelected: (one) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Container(
                                child: Text(' Confirm Delete a Product')),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('CANCEL')),
                              FlatButton(
                                  onPressed: () {}, child: Text('DELETE')),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            );
          }),
    );
  }

//  String getData() {
//    firestore.collection("products").getDocuments().then((QuerySnapshot snapshot){
//      snapshot.documents.forEach((f)=> )
//    });
//  }
}
