import 'package:culture_flutter_client/main.dart';
import 'package:culture_flutter_client/screens/festival_detail_screen.dart';
import 'package:culture_flutter_client/screens/forgot_password_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';
import '../utils/validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRegistered = false;
  String checkingUserState = "Welcome";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Culture Festival"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, '/auth'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(48),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                <Widget>[
                  Container(
                    padding: const EdgeInsets.all(24),
                    child:
                      Text(checkingUserState, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus && emailController.text.isNotEmpty) {
                        checkIfEmailExists(emailController.text);
                      }
                    },
                    child:
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (input) => Validator.isValidEmail(input)
                            ? null
                            : "Please provide a valid email address.",
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(),
                          labelText: "Email"
                        ),
                  )),
                  const Divider(),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (pass) => Validator.isValidPassword(pass)
                        ? null
                        : "Need at least 6 chars in [a-zA-z0-9-_#?*()]."),
                  const Divider(height: 48),
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child:
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                        icon: const Icon(Icons.lock_open, size: 24),
                        label: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          if (isRegistered) {
                            signIn();
                          } else {
                            signUp();
                          }
                        })),
                  const SizedBox(height: 24)
                ] +
                (isRegistered
                    ? <Widget>[
                        GestureDetector(
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()),
                          ),
                        )
                      ]
                    : []),
          ),
        ),
      ),
    );
  }

  void checkIfEmailExists(String email) async {
    if (Validator.isValidEmail(email)) {
      setState(() {
        checkingUserState = "Checking ...";
      });
      FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email)
          .then((method) => method.contains("password"))
          .then((value) =>
          setState(() {
            isRegistered = value;
            if (value) {
              checkingUserState = "Welcome back!";
            } else {
              checkingUserState = "Please sign up";
            }
          }));
    }
  }

  void signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).then((cred) =>
        cred.user!.updateDisplayName("User ${generateRandomString(6)}")
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
