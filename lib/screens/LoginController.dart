import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends StatefulWidget {
  LoginControllerState createState() => new LoginControllerState();
}

class LoginControllerState extends State<LoginController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Authentification"),
      ),
      body: new Text("Authentification"),
    );
  }
}
