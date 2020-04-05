import 'package:e_commerce_app/admin/Admin%20login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/admin/admin.dart';
import 'package:e_commerce_app/pages/login.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,100.0,20.0,100.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      blurRadius: 20.0,
                    )
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:100.0),
                    child: Container(child: Image.asset("images/lg.jpg", width: 130,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:100.0,left: 13.0,right: 13.0,bottom:20.0 ),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => new AdminLogin()));
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Admin Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,fontStyle: FontStyle.italic),
                        ),
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => new Login()));
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Customer Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,fontStyle: FontStyle.italic),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
