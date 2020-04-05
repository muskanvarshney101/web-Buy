import 'package:e_commerce_app/admin/Admin%20login.dart';
import 'package:e_commerce_app/pages/home.dart';
import 'package:e_commerce_app/pages/login.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../db/users.dart';

class AdminSignIn extends StatefulWidget {
  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  UserService userService = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _Password = TextEditingController();
  TextEditingController _nameText = TextEditingController();
  TextEditingController _ConfirmPassword = TextEditingController();
  SharedPreferences preferences;
  String gender;
  String groupValue = "male";
  bool hidepass = true;
  bool loading = false;
  bool isLoggedin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: <Widget>[

          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,50,15.0,30),
            child: Container(
              decoration: BoxDecoration(color: Colors.white,boxShadow: [
                BoxShadow(color: Colors.grey),

              ],borderRadius: BorderRadius.circular(10)),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all( 15.0),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'images/lg.jpg',
                            width: 190,
                            height: 150,
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
                            child: ListTile(
                              title: TextFormField(
                                controller: _nameText,
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    icon: Icon(Icons.perm_identity),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "name field cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
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
                            child: ListTile(
                              title: TextFormField(
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
                                    border: InputBorder.none),
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
                        const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _ConfirmPassword,
                                obscureText: hidepass,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  icon: Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "enter the password";
                                  } else if (value.length < 6) {
                                    return "password should be least 6 character";
                                  } else if (_Password.text != value) {
                                    return "Passowrds does not match ";
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
                        const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.pink,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async {
                                validateForm();
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>new AdminLogin()));
                            },
                            child: Text(
                              "I already have an account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 10),
                            )),
                      ),

                    ],
                  )),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                color: Colors.white60.withOpacity(0.7),
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



  Future validateForm() async {
    FormState formState = formKey.currentState;
    formState.reset();
    try {
      if (formState.validate()) {
        FirebaseUser user = await firebaseAuth.currentUser();
        setState(() {
          loading = true;
        });
        if (user == null) {
          AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(
              email: _emailTextController.text, password: _Password.text);
          FirebaseUser createuser = result.user;

          userService.userData(_nameText.text, _emailTextController.text,
              _Password.text, createuser.uid);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          Fluttertoast.showToast(msg: 'sigin in successfully');
          setState(() {
            loading = false;
          });
        }
      }
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          /// `foo#bar.com` has alread been registered.
          Fluttertoast.showToast(
              msg: "email Already exist with another account");
          setState(() {


            loading = false;
          });
        }
      }
    }
  }
}
