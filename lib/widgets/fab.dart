import 'package:culture_flutter_client/view_models/festival_detail_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';

enum PageType {
  welcome, festivalList, festivalMap, favorites, festivalDetail,
}

class NavigationFab extends StatefulWidget {

  final PageType currentPageType;

  final Function()? onShare;

  const NavigationFab({super.key, required this.currentPageType, this.onShare});

  @override
  State<NavigationFab> createState() => NavigationFabState();
}

class NavigationFabState extends State<NavigationFab> {
  @override
  Widget build(BuildContext context) {

    Map<PageType, FloatingActionButton> buttons = {
      PageType.welcome: FloatingActionButton.small(
        tooltip: "Home",
        heroTag: "welcomeBtn",
        child: const Icon(Icons.home),
        onPressed: () => Navigator.pushNamed(context, '/welcome'),
      ),
      PageType.festivalList: FloatingActionButton.small(
        tooltip: "List",
        heroTag: "listBtn",
        child: const Icon(Icons.list),
        onPressed: () => Navigator.pushNamed(context, '/list'),
      ),
      PageType.festivalMap: FloatingActionButton.small(
        tooltip: "Map",
        heroTag: "mapBtn",
        child: const Icon(Icons.map),
        onPressed: () => Navigator.pushNamed(context, '/map'),
      ),
      PageType.favorites: FloatingActionButton.small(
        tooltip: "Favorites",
        heroTag: "favBtn",
        child: const Icon(Icons.favorite),
        onPressed: () => Navigator.pushNamed(context, '/fav'),
      ),
    };

    final share = FloatingActionButton.small(
      tooltip: "Share",
      heroTag: "shareBtn",
      child: const Icon(Icons.share),
      onPressed: () => widget.onShare!,
    );

    final children =
      <Widget>[FloatingActionButton.small(
        tooltip: "Log out",
        heroTag: "logoutBtn",
        child: const Icon(Icons.logout),
        onPressed: () => FirebaseAuth.instance.signOut(),
      )]
      +
        (widget.currentPageType == PageType.festivalDetail ? [share] : <Widget>[]) +
          buttons.entries.where((element) => element.key != widget.currentPageType).map((e) => e.value).toList();



    return ExpandableFab(
      type: children.length > 4 ? ExpandableFabType.up : ExpandableFabType.left,
      distance: 60,
      children:
        children
    );
  }
}