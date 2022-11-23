import 'package:culture_flutter_client/screens/auth_choice_screen.dart';
import 'package:culture_flutter_client/screens/auth_screen.dart';
import 'package:culture_flutter_client/screens/home_screen.dart';
import 'package:culture_flutter_client/screens/login_screen.dart';
import 'package:culture_flutter_client/screens/sign_up_screen.dart';
import 'package:culture_flutter_client/services/utils.dart';
import 'package:culture_flutter_client/services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      routes: {
        '/signup': (context) => SignUpScreen(
              onClickedSignIn: () {},
            ),
        '/auth': (context) => AuthChoiceScreen(),
        '/login': (context) => LoginScreen(
              onClickedSignUp: () {},
            ),
        '/home': (context) => HomeScreen()
      },
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            }
            //if user is sign in
            else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return AuthChoiceScreen();
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
