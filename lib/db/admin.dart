import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{
  final String uid;
//  String ref ='users';
  UserService({this.uid});

  final CollectionReference userCollection =Firestore.instance.collection('Admin');

  Future userData(String name,String email,String password,String id) async{


  }

}

