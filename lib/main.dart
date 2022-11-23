import 'package:culture_flutter_client/screens/festival_list_screen.dart';
import 'package:culture_flutter_client/screens/welcome_screen.dart';
import 'package:culture_flutter_client/view_models/festival_list_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'notifications/Token.dart';
import 'notifications/NotificationWidget.dart';
import 'notifications/Permissions.dart';

@pragma('vm:entry:point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  showFlutterNotifications(message);
}

late AndroidNotificationChannel channel;

bool isFlutterNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if(isFlutterNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'festival_notification', // id
    'Nouveau festival disponible',
    description:
        'Découvrez un nouveau festival !',
    importance: Importance.high// title
  );

  flutterLocalNotificationsPlugin = FlutterNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}
}

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
}

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
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // title: title,
      // home: EntryPoint(title: title),
      routerConfig: _router,
    );
  }
}