
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../services/dummy_service.dart';
import '../utils/single_string_argument.dart';
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

  void search(List<Suggestion> tags) {
    if (tags.isEmpty) {
      final vm = Provider.of<MainListViewModel>(context, listen: false);
      setState(() {
        favorites = vm.favorites;
      });
    } else {
      setState(() {
        favorites = favorites.where((entry) =>
            tags.any((tag) => FestivalViewModel.getLabelBySuggestType(tag.type, entry).toLowerCase().contains(tag.content))).toList();
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

    List<Suggestion> tags = [];

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
                onTapped: (Suggestion value) {
                  tags.remove(value);
                  search(tags);
                },
                onChanged: (List<Suggestion> value) {
                  tags = value;
                  search(tags);
                }))
              ),
              Expanded(
                child: FestivalList(
                  festivals: favorites,
                  favorites: favorites,
                  scrollController: ScrollController(),
                  onDelete: (fest) => remove(fest),
                  onClick: (id) =>
                      Navigator.pushNamed(
                        context,
                        ExtractSingleArgumentWidget.routeName,
                        arguments: SingleArgument(id.toString()))
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
