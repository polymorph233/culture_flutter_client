import 'package:culture_flutter_client/view_models/festival_detail_view_model.dart';
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
        onPressed: () => context.go("/"),
      ),
      PageType.festivalList: FloatingActionButton.small(
        tooltip: "List",
        heroTag: "listBtn",
        child: const Icon(Icons.list),
        onPressed: () => context.go("/list"),
      ),
      PageType.festivalMap: FloatingActionButton.small(
        tooltip: "Map",
        heroTag: "mapBtn",
        child: const Icon(Icons.map),
        onPressed: () => context.go("/map"),
      ),
      PageType.favorites: FloatingActionButton.small(
        tooltip: "Favorites",
        heroTag: "favBtn",
        child: const Icon(Icons.favorite),
        onPressed: () => context.go("/fav"),
      ),
    };

    final share = FloatingActionButton.small(
      tooltip: "Share",
      heroTag: "shareBtn",
      child: const Icon(Icons.share),
      onPressed: () => widget.onShare!,
    );

    final children = (widget.currentPageType == PageType.festivalDetail ? [share] : <Widget>[]) +
        buttons.entries.where((element) => element.key != widget.currentPageType).map((e) => e.value).toList();

    return ExpandableFab(
      type: children.length > 4 ? ExpandableFabType.up : ExpandableFabType.fan,
      distance: 60,
      children:
        children
    );
  }
}