import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  SignUpScreenState createState() => new SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  String _login = '';
  String _loginS = '';
  String _email = '';
  String _emailS = '';
  String _password1 = '';
  String _password1S = '';
  String _password2 = '';
  String _password2S = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text("Culture Festival"),
        centerTitle: true,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () => context.go("/"),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SIGN UP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black),
              ),
              Divider(),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Your login',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _login = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          _loginS = value;
                        });
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Your email',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          _emailS = value;
                        });
                      },
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Your password',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password1 = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          _password1S = value;
                        });
                      },
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password2 = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          _password2S = value;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => context.go("/welcome"),
                  icon: Icon(Icons.skip_next_sharp))
            ],
          ),
        ),
      ),
    );
  }
}
