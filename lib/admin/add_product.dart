import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/database/product.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../database/category.dart';
import '../database/brand.dart';
import 'dart:convert';

class Add_Product extends StatefulWidget {
  @override
  _Add_ProductState createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  ProductProvider productProvider =ProductProvider();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController DescriptionController =TextEditingController();
  TextEditingController ConditionController =TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> category = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoryDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  File _Image1;
  List<String> colors = <String>[];
  bool onSale = false;
  bool featured = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: grey.withOpacity(0.5), width: 2.5),
                            onPressed: () {
                              _selectImage(
                                  ImagePicker.pickImage(
                                      source: ImageSource.gallery),
                                  1);
                            },
                            child: _displayChild1()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'enter a product name with 10 characters at maximum',
                          textAlign: TextAlign.center,
                          style: TextStyle(color:Colors.blue, fontSize: 12),
                        ),
                      ),
                      Center(
                          child: Text(
                            "Avaiable colors",
                            textAlign: TextAlign.center,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(productProvider.selectedColors.contains('red')){
                                  productProvider.removeColor('red');
                                }else{
                                  productProvider.addColors('red');

                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                  color: productProvider.selectedColors.contains('red') ? Colors.blue : grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                ),),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(productProvider.selectedColors.contains('yellow')){
                                  productProvider.removeColor('yellow');
                                }else{
                                  productProvider.addColors('yellow');

                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                  color: productProvider.selectedColors.contains('yellow') ? red : grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                  ),
                                ),),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(productProvider.selectedColors.contains('blue')){
                                  productProvider.removeColor('blue');
                                }else{
                                  productProvider.addColors('blue');

                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                  color: productProvider.selectedColors.contains('blue') ? red : grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                  ),
                                ),),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(productProvider.selectedColors.contains('green')){
                                  productProvider.removeColor('green');
                                }else{
                                  productProvider.addColors('green');

                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                  color: productProvider.selectedColors.contains('green') ? red : grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                  ),
                                ),),
                            ),
                          ),




                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(productProvider.selectedColors.contains('white')){
                                  productProvider.removeColor('white');
                                }else{
                                  productProvider.addColors('white');

                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                  color: productProvider.selectedColors.contains('white') ? red : grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                  ),
                                ),),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                if(productProvider.selectedColors.contains('black')){
                                  productProvider.removeColor('black');
                                }else{
                                  productProvider.addColors('black');

                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(width: 24, height: 24, decoration: BoxDecoration(
                                  color: productProvider.selectedColors.contains('black') ? red : grey,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: black,
                                  ),
                                ),),
                            ),
                          ),
                        ],
                      ),

                      Center(
                          child: Text(
                            "Avaiable sizes",
                            textAlign: TextAlign.center,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: selectedSizes.contains('XS'),
                            onChanged: (value) => changedSelectedSize('XS'),
                          ),
                          Text("XS",style: TextStyle(fontSize: 10),),
                          Checkbox(
                            value: selectedSizes.contains('S'),
                            onChanged: (value) => changedSelectedSize('S'),
                          ),
                          Text("S",style: TextStyle(fontSize: 10)),
                          Checkbox(
                              value: selectedSizes.contains('M'),
                              onChanged: (value) => changedSelectedSize('M')),
                          Text("M",style: TextStyle(fontSize: 10)),
                          Checkbox(
                              value: selectedSizes.contains('L'),
                              onChanged: (value) => changedSelectedSize('L')),
                          Text("L",style: TextStyle(fontSize: 10)),
                          Checkbox(
                              value: selectedSizes.contains('XL'),
                              onChanged: (value) => changedSelectedSize('XL')),
                          Text("XL",style: TextStyle(fontSize: 10)),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Sale"),
                              SizedBox(width: 10,),
                              Switch(value: onSale, onChanged: (value){
                                setState(() {
                                  onSale = value;
                                });
                              })
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Featured"),
                              SizedBox(width: 10,),
                              Switch(value: featured, onChanged: (value){
                                setState(() {
                                  featured = value;
                                });
                              })
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: productNameController,
                          decoration: InputDecoration(hintText: "Product name",hintStyle: TextStyle(fontSize: 12)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "you must enter the product name";
                            } else if (value.length > 10) {
                              return "Product name does not exceed than 10 character";
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Category',
                              style: TextStyle(color: red),
                            ),
                          ),
                          DropdownButton(
                            items: categoryDropDown,
                            onChanged: changedSelectCategory,
                            value: _currentCategory,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Brand',
                              style: TextStyle(color: red),
                            ),
                          ),
                          DropdownButton(
                            items: brandDropDown,
                            onChanged: changedSelectBrands,
                            value: _currentBrand,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                               hintText: "Quantity",hintStyle: TextStyle(fontSize: 12)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "you must enter the quantity of the product";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                             hintText: "Price",hintStyle: TextStyle(fontSize: 12)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "you must enter the price of the product";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: DescriptionController,
                          decoration: InputDecoration(
                              hintText: "Discription of the product",hintStyle: TextStyle(fontSize: 12)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "you must enter the price of the product";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: ConditionController,
                          decoration: InputDecoration(
                              hintText: "Condition of product",hintStyle: TextStyle(fontSize: 12)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "you must enter the price of the product";
                            }
                          },
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(
                            top: 100.0, ),
                        child: FlatButton(
                          color: Colors.blueGrey,
                          textColor: white,
                          child: Text('add product'),
                          onPressed: () {
                            validateAndUpload();
                          },
                        ),
                      )
                    ],
                  ),
              ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getCategories();
    getBrands();
//    getCategoryDropDown();

//    _currentCategory = categoryDropDown[0].value;
  }

  void getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategoriesList();

    setState(() {
      category = data;
      categoryDropDown = getCategoryDropDown();
      _currentCategory = category[0].data['category'];
    });
  }

  void getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrandsList();
    setState(() {
      brands = data;
      brandDropDown = getBrandDropDown();
      _currentBrand = brands[0].data['brand'];
    });
  }

  List<DropdownMenuItem<String>> getCategoryDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < category.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(category[i]['category']),
              value: category[i]['category'],
            ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(brands[i]['brand']),
              value: brands[i]['brand'],
            ));
      });
    }
    return items;
  }

  changedSelectCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changedSelectBrands(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

  changedSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      selectedSizes.remove(size);
    } else {
      setState(() {
        selectedSizes.add( size);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _Image1 = tempImg);
        break;

    }
  }

  Widget _displayChild1() {
    if (_Image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          14,
          40,
          14,
          40,
        ),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _Image1,
        fit: BoxFit.fill,
        width: double.infinity,

      );
    }
  }



  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {

      setState(() => isLoading = true);

      if (_Image1 != null ) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_Image1);
          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);


          task1.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            List<String> imageList = [imageUrl1,];
            _productService.uploadProduct(
                productName: productNameController.text,
                price: double.parse(priceController.text),
                sizes: selectedSizes,
                images: imageList,
                category: _currentCategory,
                brand: _currentBrand,
                color: colors,
                sale:onSale,
                featured:featured,
                condition:ConditionController.text,
                discription:DescriptionController.text,
                quantity: int.parse(quantityController.text));
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Fluttertoast.showToast(msg: "Product added");
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
          Fluttertoast.showToast(msg: 'select  at least one size');
        }
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
