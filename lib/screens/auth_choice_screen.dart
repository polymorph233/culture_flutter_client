import 'package:culture_flutter_client/screens/login_screen.dart';
import 'package:culture_flutter_client/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AuthChoiceScreen extends StatefulWidget {
  const AuthChoiceScreen({super.key});

  @override
  AuthChoiceScreenState createState() => new AuthChoiceScreenState();
}

class AuthChoiceScreenState extends State<AuthChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_welcome_screen.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              width: 150,
            ),
            SizedBox(height: 300),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(const Size(170, 50)),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.amberAccent,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Log in',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFF9C305)),
                minimumSize: MaterialStateProperty.all(const Size(170, 50)),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text('Sign up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
