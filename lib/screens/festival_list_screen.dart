
import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:culture_flutter_client/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
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
    final vm = Provider.of<MainListViewModel>(context, listen: false);
    
    vm.update().then((_) =>
    setState(() =>{ festivals = vm.festivals}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void search(List<Suggestion> tags) {
    if (tags.isEmpty) {
      final vm = Provider.of<MainListViewModel>(context, listen: false);
      setState(() {
        festivals = vm.festivals;
      });
    } else {
      setState(() {
        festivals = festivals.where((entry) =>
          tags.any((tag) => getLabelBySuggestType(tag.type, entry).toLowerCase().contains(tag.content))).toList();
      });
    }
  }

  String getLabelBySuggestType(SuggestionType type, FestivalViewModel viewModel) {
    switch (type) {
      case SuggestionType.rawName:
        return "${viewModel.name} ${viewModel.principalRegion} ${viewModel.principalCommune} ${viewModel.principalDepartment} ${viewModel.principalPeriod}";
      case SuggestionType.festival:
        return viewModel.name;
      case SuggestionType.region:
        return viewModel.principalRegion;
      case SuggestionType.department:
        return viewModel.principalDepartment;
      case SuggestionType.commune:
        return viewModel.principalCommune;
      case SuggestionType.period:
        return viewModel.principalPeriod;
      case SuggestionType.domain:
        return FestivalViewModel.stringOfDomain(viewModel.domain);
    }
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<MainListViewModel>(context);

    List<Suggestion> tags = [];

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
                    festivals: festivals, favorites: vm.favorites, scrollController: ScrollController(),
                    onAdd: (fest) => vm.addFavorite(fest),
                    onDelete: (fest) => vm.removeFavorite(fest),
                    onClick: (id) =>
                        context.pushNamed('festival', params: {"id": id.toString()})))//we will create this further down
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
    final vm = Provider.of<MainListViewModel>(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => vm,
        child: const FestivalListScreen()
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.festivalList)
    );
  }
}
