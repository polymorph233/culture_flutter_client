import 'package:culture_flutter_client/screens/cover_screen.dart';
import 'package:culture_flutter_client/screens/settings_screen.dart';
import 'package:culture_flutter_client/screens/login_screen.dart';
import 'package:culture_flutter_client/services/firebase_connector.dart';
import 'package:culture_flutter_client/services/utils.dart';
import 'package:culture_flutter_client/utils/single_string_argument.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:culture_flutter_client/screens/favorites_screen.dart';
import 'package:culture_flutter_client/screens/festival_detail_screen.dart';
import 'package:culture_flutter_client/screens/festival_list_screen.dart';
import 'package:culture_flutter_client/screens/map_screen.dart';
import 'package:culture_flutter_client/screens/welcome_screen.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/verify_email_screen.dart';

const USE_DATABASE_EMULATOR = false;
const emulatorPort = 9000;
final emulatorHost =
(!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
    ? '10.0.2.2'
    : 'localhost';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (USE_DATABASE_EMULATOR) {
    FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
  }

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MainListViewModel>(create: (_) => MainListViewModel()),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: Utils.messengerKey,
          navigatorKey: navigatorKey,
          routes: {
            '/auth': (context) => const CoverScreen(),
            '/login': (context) => LoginScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/welcome': (context) => WelcomeScreenEntry(),
            '/list': (context) => FestivalListEntry(),
            '/fav': (context) => FavoriteFestivalsEntry(),
            '/map': (context) => MapListEntry(),
            ExtractSingleArgumentWidget.routeName:
              (context) =>
                  ExtractSingleArgumentWidget(bodyProvider: (str) => FestivalDetailEntry(id: int.parse(str))),
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
            return const Center(child: Text('Something went wrong!\nPlease contact technical support at\nsupport@festival.app'));
          } else if (snapshot.hasData) {
            return LoginDispatchScreen();
          } else {
            return const CoverScreen();
          }
        }),
    );
  }
}