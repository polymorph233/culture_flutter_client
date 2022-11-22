
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../widgets/festival_list.dart';
import '../widgets/search_box.dart';

class FavoriteFestivalListScreen extends StatefulWidget {
  const FavoriteFestivalListScreen({super.key});

  @override
  _FavoriteFestivalListScreenState createState() => _FavoriteFestivalListScreenState();
}
class _FavoriteFestivalListScreenState extends State<FavoriteFestivalListScreen> {

  List<FestivalViewModel> favorites = [];

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<MainListViewModel>(context, listen: false);

    favorites = vm.favorites;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void search(List<String> tags) {
    if (tags.isEmpty) {
      final vm = Provider.of<MainListViewModel>(context, listen: false);
      setState(() {
        favorites = vm.favorites;
      });
    } else {
      setState(() {
        favorites = favorites.where((entry) =>
            tags.any((tag) => entry.name.contains(tag))).toList();
      });
    }
  }

  void add(FestivalViewModel fest) {
    final vm = Provider.of<MainListViewModel>(context, listen: false);
    setState(() {
      vm.addFavorite(fest);
      favorites.add(fest);
    });
  }

  void remove(FestivalViewModel fest) {
    final vm = Provider.of<MainListViewModel>(context, listen: false);
    setState(() {
      vm.removeFavorite(fest);
      favorites.remove(fest);
    });
  }

  @override
  Widget build(BuildContext context) {

    List<String> tags = [];

    final GlobalKey<ChipsInputState> _chipKey = GlobalKey();

    return Scaffold(
        appBar: AppBar(
            title: const Text("Festivals")
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Container(
                child: Expanded(child: SearchBox(
                onTapped: (String value) {
                  tags.remove(value);
                  search(tags);
                },
                onChanged: (List<String> value) {
                  tags = value;
                  search(tags);
                }))
              ),
              Expanded(
                child: FestivalList(
                  festivals: favorites, scrollController: ScrollController(),
                  onDelete: (fest) => remove(fest),
                ))
            ])
        )
    );
  }
}


class FavoriteFestivalsEntry extends StatefulWidget {
  const FavoriteFestivalsEntry({super.key});

  final String title = "All Festivals";

  @override
  State<FavoriteFestivalsEntry> createState() => _FavoriteFestivalsEntryState();
}

class _FavoriteFestivalsEntryState extends State<FavoriteFestivalsEntry> {


  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainListViewModel>(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => vm,
        child: const FavoriteFestivalListScreen()
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.favorites),
    );
  }
}
