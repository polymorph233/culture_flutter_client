import 'package:culture_flutter_client/main.dart';
import 'package:culture_flutter_client/screens/forgot_password_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRegistered = false;
  String checkingUserState = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool isValidEmail(String? email) {
    return EmailValidator.validate(email ?? "");
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (checkingUserState.isEmpty ? <Widget>[] : <Widget>[Text(checkingUserState)]) +
                <Widget>[
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
                        validator: (input) => isValidEmail(input)
                            ? null
                            : "Please provide a valid email address.",
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Your email',
                        ),
                  )),
                  const Divider(),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Your password',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (pass) => ((pass?.length ?? 0) > 6 &&
                            RegExp(r"[a-zA-Z0-9-_\?\*#\(\)]+")
                                .hasMatch(pass ?? "")
                        ? null
                        : "Should only contain [a-zA-z0-9-_#?*()] with at least 6 characters"),
                  ),
                  const Divider(),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      icon: const Icon(Icons.lock_open, size: 32),
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
                      }),
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
    if (isValidEmail(email)) {
      setState(() {
        checkingUserState = "Checking your account, please wait...";
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
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
