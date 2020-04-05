import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/model/productItem.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore firestore = Firestore.instance;

  String ref = "products";

  void uploadProduct({
    String productName,
    String brand,
    String category,
    int quantity,
    List sizes,
    List images,
    double price,
    List color,
    bool sale,
    bool featured,
    String discription,
    String condition
  }) {
    var id = new Uuid();
    String productId = id.v1();
    firestore.collection(ref).document(productId).setData({
      'quantity': quantity,
      'price': price,
      'name': productName,
      'brand': brand,
      'id': productId,
      'category': category,
      'image': images,
      'size': sizes,
      'color':color,
      'sale':sale,
      'featured':featured,
      'condition':condition,
      'discription':discription,
    });
  }
  Future<List<Product>>  getFeaturedProduct()=>
      firestore.collection(ref).where('featured',isEqualTo: true).getDocuments().then((snap){
        List<Product> featuredProducts = [];
        snap.documents.map((snapshot)=> featuredProducts.add(Product.fromSnapshot(snapshot)));
        return featuredProducts;

      });

}
