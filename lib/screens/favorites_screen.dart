
import 'package:culture_flutter_client/view_models/favorite_festival_list_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_list_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../widgets/festival_list.dart';

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
    final vm = Provider.of<FavoriteFestivalListViewModel>(context, listen: false);

    favorites = vm.festivals;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void search(List<String> tags) {
    if (tags.isEmpty) {
      final vm = Provider.of<FavoriteFestivalListViewModel>(context);
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
    final vm = Provider.of<FavoriteFestivalListViewModel>(context);
    setState(() {
      vm.addFestival(fest);
      favorites.add(fest);
    });
  }

  void remove(FestivalViewModel fest) {
    final vm = Provider.of<FavoriteFestivalListViewModel>(context);
    setState(() {
      vm.removeFestival(fest);
      favorites.remove(fest);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FestivalListViewModel>(context);

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
                  margin: const EdgeInsets.all(10),
                  child:
                  Row(children: [
                    Expanded(child: ChipsInput(
                      maxChips: 6,
                      keyboardAppearance: Brightness.dark,
                      textCapitalization: TextCapitalization.words,
                      width: MediaQuery.of(context).size.width,
                      enabled: true,
                      separator: ' ',
                      decoration: const InputDecoration(
                        hintText: 'Enter Search Keywords...',
                      ),
                      initialTags: const [],
                      autofocus: true,
                      chipBuilder: (context, state, value) {
                        return InputChip(
                          key: ObjectKey(value),
                          labelPadding: const EdgeInsets.only(left: 8.0, right: 3),
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(side: BorderSide(width: 1.8, color: Color.fromRGBO(228, 230, 235, 1))),
                          shadowColor: Colors.grey,
                          label: Text("#$value"),
                          onDeleted: () => state.deleteChip(value),
                          deleteIconColor: const Color.fromRGBO(138, 145, 151, 1),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      },
                      key: _chipKey,
                      chipTextValidator: (String value) {
                        value.contains('!');
                        return -1;
                      },
                      onChangedTag: (values) => {
                        tags = values.map((e) => e.toString()).toList()
                      },
                    )),
                    IconButton(onPressed: () =>
                        search(tags)
                        , icon: const Icon(Icons.check))
                  ],)
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


class FestivalListEntry extends StatefulWidget {
  const FestivalListEntry({super.key});

  final String title = "All Festivals";

  @override
  State<FestivalListEntry> createState() => _FestivalListEntryState();
}

class _FestivalListEntryState extends State<FestivalListEntry> {

  FestivalListViewModel festivalListViewModel = FestivalListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => festivalListViewModel,
        child: const FavoriteFestivalListScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'TODO',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
