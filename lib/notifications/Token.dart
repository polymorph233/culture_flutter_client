import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Token extends StatefulWidget {

  Token(this._builder);

  final Widget Function(String? token) _builder;

  @override
  State<StatefulWidget> createState() => _Token();

}

class _Token extends State<Token>{

  String? _token;
  late Stream<String> _tokenStream;

  void setToken(String? token) {
    setState(() {
      _token = token;
    });
  }


  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getToken(
          vapidKey: 'BCT9FvmLqTH6guyAC0QvBca0DS8tgFXyohYSSl9n9IWxNQE-jbCGrgSHvCPpew4ptiHMk-1G-zVVCOMjzDFxCJU')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(_token);
  }

}