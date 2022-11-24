import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
          color: Colors.black,
          padding: const EdgeInsets.all(96),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: const Image(

                image: AssetImage('assets/AppLogo.png'),
                width: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 48, bottom: 48),
              child: Text("FestivalApp", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white))),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(const Size(170, 50)),

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
          ],
        ),
      ),
    );
  }
}
