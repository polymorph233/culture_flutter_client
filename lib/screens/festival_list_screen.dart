
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../widgets/festival_list.dart';

class FestivalListScreen extends StatefulWidget {
  const FestivalListScreen({super.key});

  @override
  _FestivalListScreenState createState() => _FestivalListScreenState();
}
class _FestivalListScreenState extends State<FestivalListScreen> {

  List<FestivalViewModel> festivals = [];

  @override
  void initState() {
    super.initState();
    final vm = GetIt.instance.get<MainListViewModel>();
    
    vm.update().then((_) =>
    setState(() =>{ festivals = vm.festivals}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void search(List<String> tags) {
    if (tags.isEmpty) {
      final vm = GetIt.instance.get<MainListViewModel>();
      setState(() {
        festivals = vm.festivals;
      });
    } else {
      setState(() {
        festivals = festivals.where((entry) =>
          tags.any((tag) => entry.name.contains(tag))).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final vm = GetIt.instance.get<MainListViewModel>();

    List<String> tags = [];

    final GlobalKey<ChipsInputState> _chipKey = GlobalKey();

    return Scaffold(
        appBar: AppBar(
            title: const Text("All Festivals")
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
                    festivals: festivals, scrollController: ScrollController(), onAdd: (fest) => vm.addFavorite(fest)))//we will create this further down
            ])
        )
    );
  }
}


class FestivalListEntry extends StatefulWidget {
  const FestivalListEntry({super.key});

  @override
  State<FestivalListEntry> createState() => _FestivalListEntryState();
}

class _FestivalListEntryState extends State<FestivalListEntry> {


  @override
  Widget build(BuildContext context) {
    MainListViewModel mainListViewModel = GetIt.instance.get<MainListViewModel>();
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => mainListViewModel,
        child: const FestivalListScreen(),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.festivalList)
    );
  }
}
