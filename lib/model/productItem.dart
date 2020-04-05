import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  static const String BRAND = 'brand';
  static const String CATEGORY = 'category';
  static const String COLORS = 'color';
  static const String FEATURED = 'featured';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PICTURE = 'picture';
  static const String PRICE = 'price';
  static const String QUANTITY = 'quantity';
  static const String SALE = 'sale';
  static const String SIZE = 'size';

  String _brand;
  String _category;
  String _id;
  String _name;
  String _picture;
  double _price;
  int _quantity;
  List<String> _color;
  List<String> _size;
  bool _featured;
  bool _sales;

  String get category => _category;

  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  double get price => _price;

  int get quantity => _quantity;

  List<String> get color => _color;

  List<String> get size => _size;

  bool get featured => _featured;

  bool get sales => _sales;

  String get brand => _brand;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _color = data[COLORS];
    _featured = data[FEATURED];
    _id = data[ID];
    _name = data[NAME];
    _picture = data[PICTURE];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _sales = data[SALE];
    _size = data[SIZE];
  }

}
