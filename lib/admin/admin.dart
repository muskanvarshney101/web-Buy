import 'package:e_commerce_app/admin/add_product.dart';
import 'package:e_commerce_app/admin/brandList.dart';
import 'package:e_commerce_app/admin/categoryList.dart';
import 'package:e_commerce_app/admin/productList.dart';
import 'package:e_commerce_app/commomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/category.dart';
import '../database/brand.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Page { Dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.Dashboard;
  FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[

              Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.Dashboard);
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color:
                          _selectedPage == Page.Dashboard ? active : notActive,
                    ),
                    label: Text("Dashboard")),
              ),
              Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.manage);
                    },
                    icon: Icon(
                      Icons.format_list_numbered,
                      color: _selectedPage == Page.manage ? active : notActive,
                    ),
                    label: Text("Manage")),
              ),

              IconButton(icon: Icon(Icons.person_pin), onPressed:()async{
                await signout();
              })
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,

        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.Dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                  onPressed: null,
                  icon:
                      Icon(Icons.attach_money, size: 30.0, color: Colors.green),
                  label: Text(
                    "12,000",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green),
                  )),
              title: Text(
                "Revenue",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.people_outline),
                            label: Text("Users",
                                style: TextStyle(fontSize: 10.0))),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 50.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text(
                              "Category",
                              style: TextStyle(fontSize: 10.0),
                            )),
                        subtitle: Text(
                          '23',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 50.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.track_changes),
                            label: Text("Products",
                                style: TextStyle(fontSize: 10.0))),
                        subtitle: Text(
                          '120',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 50.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.tag_faces),
                            label:
                                Text("Sold", style: TextStyle(fontSize: 10.0))),
                        subtitle: Text(
                          '13',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 50.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.shopping_cart),
                            label: Text("Orders",
                                style: TextStyle(fontSize: 10.0))),
                        subtitle: Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 50.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.close),
                            label: Text("Return")),
                        subtitle: Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 50.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
        break;
      case Page.manage:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Add Product"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Add_Product()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.change_history),
                title: Text("Products list"),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>new Product_List()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.add_circle),
                title: Text("Add Category"),
                onTap: () {
                  _categoryAlert();
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.category),
                title: Text("Category list"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new Category_List()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.add_circle_outline),
                title: Text("Add brand"),
                onTap: () {
                  _brandAlert();
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.library_books),
                title: Text("brand list"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Brand_List()));
                },
              ),
            ],
          ),
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    final _showSnack = () => Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Button Tapped"),
            duration: Duration(milliseconds: 200),
          ),
        );
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Caterory can not empty';
            }
          },
          decoration: InputDecoration(hintText: "add category"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              validationCategory();
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Brand can not empty';
            }
          },
          decoration: InputDecoration(hintText: "add brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              validationbrand();
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void validationCategory() {
    FormState formState = _categoryFormKey.currentState;
    if (formState.validate()) {
      _categoryService.createCategory(categoryController.text);
      formState.reset();
      Fluttertoast.showToast(msg: 'category created');
    }
  }

  void validationbrand() {
    FormState formState = _brandFormKey.currentState;
    if (formState.validate()) {
      _brandService.createbrand(brandController.text);
      formState.reset();
      Fluttertoast.showToast(msg: 'add brand');
    }
  }

  signout() async{
    await firebaseAuth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new Home_Page()));
  }
}
