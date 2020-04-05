import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/database/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category_List extends StatefulWidget {
  @override
  _Category_ListState createState() => _Category_ListState();

}

class _Category_ListState extends State<Category_List> {
  CategoryService _categoryService =CategoryService();
  List<DocumentSnapshot> category = <DocumentSnapshot>[];
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
          'Category List',
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
//                      category[index]['category'],
                      style: TextStyle(color: Colors.black),
                    ),
//                    value: category[i]['category',
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
                                child: Text(' Confirm Delete a category ')),
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
                    ),),
              ),
            );
          }),
    );
  }

//   getData() async {
//    List<DocumentSnapshot> data = await _categoryService.getCategoriesList();
//    category = data;






}
