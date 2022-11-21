import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MainAppController extends StatefulWidget {
  MainAppState createState() => new MainAppState();
}

class MainAppState extends State<MainAppController> {
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
