import 'package:culture_flutter_client/screens/auth_choice_screen.dart';
import 'package:culture_flutter_client/screens/delete_account.dart';
import 'package:culture_flutter_client/screens/home_screen.dart';
import 'package:culture_flutter_client/screens/login_screen.dart';
import 'package:culture_flutter_client/services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:culture_flutter_client/screens/favorites_screen.dart';
import 'package:culture_flutter_client/screens/festival_detail_screen.dart';
import 'package:culture_flutter_client/screens/festival_list_screen.dart';
import 'package:culture_flutter_client/screens/map_screen.dart';
import 'package:culture_flutter_client/screens/welcome_screen.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/verify_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreenEntry(),
    ),
    GoRoute(
      path: "/list",
      builder: (context, state) => const FestivalListEntry(),
    ),
    GoRoute(
      path: "/fav",
      builder: (context, state) => const FavoriteFestivalsEntry(),
    ),
    GoRoute(
      path: "/map",
      builder: (context, state) => const MapListEntry(),
    ),
    GoRoute(
      path: "/fest/:id",
      name: "festival",
      builder: (context, state) {
        int id = int.parse(state.params['id']!);
        return FestivalDetailEntry(id: id);
      }
    )
    /* TODO GoRoute to comment list
     * */
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MainListViewModel>(create: (_) => MainListViewModel())
        ],
        child: MaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          navigatorKey: navigatorKey,
          routes: {
            '/auth': (context) => const AuthChoiceScreen(),
            '/login': (context) => LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/deleteaccount': (context) => const DeleteAccountScreen()
          },
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        )
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            return VerifyEmailScreen();
          } else {
            return const AuthChoiceScreen();
          }
        }),
    );
  }
}