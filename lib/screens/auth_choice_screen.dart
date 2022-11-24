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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_welcome_screen.jpg'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(96),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Image(
              image: AssetImage('assets/images/logo2.png'),
              width: 200,
            ),
            const Spacer(),
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
            const Spacer(),
          ],
        ),
      ),
    ));
  }
}
