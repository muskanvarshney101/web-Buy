import 'package:e_commerce_app/admin/AdminSignIn.dart';
import 'package:e_commerce_app/admin/admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_commerce_app/pages/Sign_UP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
//  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _Password = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;
  bool hidepass = true;

//  @override
//  void initState() {
//    super.initState();
//    isSignedIn();
//  }

//  void isSignedIn() async {
//    setState(() {
//      loading = true;
//    });
//    await firebaseAuth.currentUser().then((user) {
//      if (user != null) {
//        setState(() => isLoggedin = true);
//      }
//    });
//    preferences = await SharedPreferences.getInstance();
//    isLoggedin = await googleSignIn.isSignedIn();
//    if (isLoggedin) {
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => HomePage()));
//    }
//    setState(() {
//      loading = false;
//    });
//  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20.0, top: 120.0, bottom: 100.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[350],
                        blurRadius: 20.0,
                      )
                    ]
                ),
                child: Form(
                    key: formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'images/lg.jpg',
                              width: 150,
                              height: 130,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.alternate_email),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "enter the email address";
                                  }
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value)) {
                                    return "Please make sure your email address is valid";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _Password,
                                  obscureText: hidepass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "enter the password";
                                    } else if (value.length < 6) {
                                      return "password should be least 6 character";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        hidepass = false;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(13.0, 8.0, 10.0, 0.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.pink,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () {
                                  validateForm();
                                },
                                minWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminSignIn()));
                                  },
                                  child: Text(
                                    'Create an account',
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black26,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    )),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                color: Colors.white38.withOpacity(0.7),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() async {

    FormState formState = formKey.currentState;
    // formState.reset();
    try {
      if (formState.validate()) {

        FirebaseUser user = await firebaseAuth.currentUser();

        setState(() {
          loading = true;
        });

        if (user == null) {
          await firebaseAuth.signInWithEmailAndPassword(
              email: _emailTextController.text, password: _Password.text);

//       return userFormFirebaseUsser(user);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => new Admin()));
          Fluttertoast.showToast(msg: 'Login successfully');
          setState(() {
            loading = false;
          });
        }
      }
    } on AuthException catch (error) {
      return _buildErrorDialog(context, error.message);
    } on Exception catch (error) {
      return _buildErrorDialog(context, error.toString());
    }
  }

  Future _buildErrorDialog(BuildContext context, String message) {
    return showDialog(context: context, builder: (_) =>
        AlertDialog(
          title: Text("Message"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(onPressed: () {
              Navigator.pop(context);
              setState(() {
                loading = false;
              });
            }, child: Text('Cancel'))
          ],
        ));
  }
}