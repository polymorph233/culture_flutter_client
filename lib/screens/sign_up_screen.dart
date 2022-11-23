import 'package:culture_flutter_client/main.dart';
import 'package:culture_flutter_client/services/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  SignUpScreenState createState() => new SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

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
          onPressed: () => Navigator.pushNamed(context, '/auth'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              FlutterLogo(size: 120),
              SizedBox(height: 20),
              Text(
                'SIGN UP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black),
              ),
              Divider(),
              SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Your email',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              SizedBox(height: 4),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Your password',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min. 6 characters'
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                icon: Icon(Icons.lock_open, size: 32),
                label: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: signUp,
              ),
              SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      text: 'Already have an account?   ',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Log In',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
