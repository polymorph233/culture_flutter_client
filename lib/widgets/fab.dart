import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';

enum PageType {
  welcome, festivalList, festivalMap, favorites, festivalDetail,
}

class NavigationFab extends StatefulWidget {

  final PageType currentPageType;

  const NavigationFab({super.key, required this.currentPageType});

  @override
  State<NavigationFab> createState() => NavigationFabState();
}

class NavigationFabState extends State<NavigationFab> {
  @override
  Widget build(BuildContext context) {

    Map<PageType, FloatingActionButton> buttons = {
      PageType.welcome: FloatingActionButton.small(
        heroTag: "welcomeBtn",
        child: const Icon(Icons.home),
        onPressed: () => context.go("/"),
      ),
      PageType.festivalList: FloatingActionButton.small(
        heroTag: "listBtn",
        child: const Icon(Icons.list),
        onPressed: () => context.go("/list"),
      ),
      PageType.festivalMap: FloatingActionButton.small(
        heroTag: "mapBtn",
        child: const Icon(Icons.map),
        onPressed: () {},
      ),
      PageType.favorites: FloatingActionButton.small(
        heroTag: "favBtn",
        child: const Icon(Icons.favorite),
        onPressed: () => context.go("/fav"),
      ),
    };

    return ExpandableFab(
      children: buttons.entries.where((element) => element.key != widget.currentPageType).map((e) => e.value).toList()
    );
  }
}