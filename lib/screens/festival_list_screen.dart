
import 'package:culture_flutter_client/view_models/favorite_festival_list_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_list_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:flutter/material.dart';
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
    final vm = Provider.of<FestivalListViewModel>(context, listen: false);
    
    vm.update().then((_) => festivals = vm.festivals);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void search(List<String> tags) {
    if (tags.isEmpty) {
      final vm = Provider.of<FestivalListViewModel>(context, listen: false);
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

    final fav_vm = Provider.of<FavoriteFestivalListViewModel>(context);

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
                    festivals: festivals, scrollController: ScrollController(), onAdd: (fest) => fav_vm.addFestival(fest)))//we will create this further down
            ])
        )
    );
  }
}


class FestivalListEntry extends StatefulWidget {
  const FestivalListEntry({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
        child: const FestivalListScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'TODO',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
