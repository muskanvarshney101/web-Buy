import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
class CategoryService{
  Firestore firestore =Firestore.instance;

  String ref='category';

  void createCategory(String Name){
    var id = new Uuid();
    String categoryId = id.v1();
    firestore.collection(ref).document(categoryId).setData({'category':Name});

  }
  Future<List<DocumentSnapshot>> getCategoriesList() =>
     firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });

  Future<List<DocumentSnapshot>>  getsuggestion(String suggestion)=>
    firestore.collection(ref).where('category',isEqualTo: suggestion).getDocuments().then((snap){
      return snap.documents;
    });

  void initState(){
    getData();
  }

  void getData() {

  }
  
}