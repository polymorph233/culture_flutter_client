import 'package:culture_flutter_client/screens/favorites_screen.dart';
import 'package:culture_flutter_client/screens/festival_list_screen.dart';
import 'package:culture_flutter_client/screens/welcome_screen.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
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
    ),
    GoRoute(
      path: "/fav",
      builder: (context, state) => const FavoriteFestivalsEntry(),
    ),
    /* TODO GoRoute to comment list
     * */
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainListViewModel>(create: (_) => MainListViewModel())],
      child: MaterialApp.router(
      // title: title,
      // home: EntryPoint(title: title),
      routerConfig: _router,
    ));
  }
}