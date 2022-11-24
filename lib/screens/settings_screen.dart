import 'package:culture_flutter_client/screens/delete_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../services/utils.dart';
import '../utils/validator.dart';
import '../widgets/fab.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => new SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordInput = false;

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          usernameController.text = user.displayName!.isEmpty ? "" : user.displayName!;
          emailController.text = user.email!;
        });
      }
    });
  }


  void changeDisplayName() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        user.updateDisplayName(usernameController.text);
      }
      update();
    });
  }

  void changeEmail() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        user.updateEmail(emailController.text);
      }
      update();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final user = firebaseAuth.instance.currentUser;

    final currentPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body:
        (usernameController.text.isEmpty || emailController.text.isEmpty)
        ? const Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(child: Column(children:
            <Widget>[
                const Icon(Icons.account_circle, size: 128),
                const SizedBox(height: 32),
                Row(children: [
                  Expanded(child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      labelText: "Display name"),
                    controller: usernameController, style: const TextStyle(fontSize: 16))),
                  IconButton(icon: const Icon(Icons.edit), onPressed: () =>
                    changeDisplayName())
                ]),
                const SizedBox(height: 32),
                Row(children: [
                  Expanded(child: TextFormField(
                    validator: (input) => Validator.isValidEmail(input)
                      ? null
                      : "Please provide a valid email address.",
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder(),
                      labelText: "Email"),
                    controller: emailController, style: const TextStyle(fontSize: 16))),
                  IconButton(icon: const Icon(Icons.edit), onPressed: () =>
                    changeEmail())
                ]),
                const SizedBox(height: 32),
                Row(children: [
                  Expanded(child: TextFormField(
                    validator: (pass) => Validator.isValidPassword(pass)
                      ? null
                      : "Need at least 6 chars in [a-zA-z0-9-_#?*()].",
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: "Password"),
                    controller: passwordController, style: const TextStyle(fontSize: 16))),
                  passwordInput ?
                  IconButton(icon: const Icon(Icons.remove),
                    onPressed: () =>
                      setState(() {
                        passwordController.text = "";
                        passwordInput = false;
                      })) :
                  IconButton(icon: const Icon(Icons.edit), onPressed: () =>
                    setState(() {
                      passwordInput = true;
                    }))
                ])
              ] +
                (passwordInput
                  ? <Widget>[
                    SizedBox(height: 32),
                    Row(children: [
                      Expanded(child: TextFormField(
                        validator:(pass) => Validator.isValidPassword(pass)
                          ? null
                          : "Need at least 6 chars in [a-zA-z0-9-_#?*()].",
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                          labelText: "Password"),
                        controller: currentPasswordController, style: const TextStyle(fontSize: 16))),
                      IconButton(icon: const Icon(Icons.edit), onPressed: () =>
                      changePassword(currentPasswordController.text))
                    ]),
                    SizedBox(height: 32)
                  ]
                  : [const SizedBox(height: 32)])
               + [

            Container(
              padding: const EdgeInsets.only(left: 48, right: 48),
              child: ElevatedButton.icon(
                  style:
                  ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(32)),
                  icon: const Icon(Icons.lock_open, size: 16),
                  label: const Text(
                    'Sign out',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => FirebaseAuth.instance.signOut()),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.only(left: 48, right: 48),
              child: ElevatedButton.icon(
                style:
                ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(32)),
                icon: const Icon(Icons.delete_outlined, size: 16),
                label: const Text(
                  'Delete account',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, '/deleteaccount')),)
          ],
        ),
      ),
    ));
  }

  changePassword(String current) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.pop();
  }
}

class SettingsEntry extends StatefulWidget {
  const SettingsEntry({super.key});

  final String title = "Settings";

  @override
  State<SettingsEntry> createState() => _SettingsEntryState();
}

class _SettingsEntryState extends State<SettingsEntry> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (context) {},
          child: const SettingsScreen()
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.favorites),
    );
  }
}