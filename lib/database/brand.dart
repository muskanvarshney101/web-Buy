import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class BrandService {
  Firestore firestore = Firestore.instance;
  String ref = "brands";

  void createbrand(String Name) {
    var id = new Uuid();
    String brandId = id.v1();
    firestore.collection(ref).document(brandId).setData({'brand': Name});
  }

  Future<List<DocumentSnapshot>> getBrandsList() =>
    firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  Future<List<DocumentSnapshot>>  getsuggestion(String suggestion)=>
      firestore.collection(ref).where('brands',isEqualTo: suggestion).getDocuments().then((snap){
        return snap.documents;
      });

}


