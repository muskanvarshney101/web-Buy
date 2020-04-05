import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_commerce_app/pages/Sign_UP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _Password = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;
  bool hidepass = true;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    await firebaseAuth.currentUser().then((user) {
      if (user != null) {
        setState(() => isLoggedin = true);
      }
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if (isLoggedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult =
    await firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    if (user != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("user")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> document = result.documents;
      if (document.length == 0) {
        Firestore.instance.collection("user").document(user.uid).setData({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoUrl
        });
        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName);
        await preferences.setString("email", user.email);
      } else {
        await preferences.setString("id", document[0]['id']);
        await preferences.setString("username", document[0]['username']);
        await preferences.setString("email", document[0]['email']);
        Fluttertoast.showToast(msg: "Login successfully"); //...
        setState(() {
          loading = false;
        });
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else {
      Fluttertoast.showToast(msg: "Login Failed:(");
    }
  }

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

//                              Padding(
//                                padding: const EdgeInsets.all(5.0),
//                                child: Text(
//                                  'ForgetPassword?',
//                                  style:
//                                  TextStyle(fontSize: 12, color: Colors.black26,fontWeight: FontWeight.bold),
//                                ),
//                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
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
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'or Login with',
                                  style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Material(
                                  child: MaterialButton(
                                    onPressed: () {
                                      handleSignIn();
                                    },
                                    child: Image.asset(
                                      "images/google.jpg",
                                      width: 68.0,
                                    ),
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
              context, MaterialPageRoute(builder: (context) => HomePage()));
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