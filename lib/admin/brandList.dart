import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Brand_List extends StatefulWidget {
  @override
  _Brand_ListState createState() => _Brand_ListState();
}

class _Brand_ListState extends State<Brand_List> {
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
          'Brands ',
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
                    title: Text(
                      "Name",
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
                                child: Text(' Confirm Delete a Brand ')),
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
}
