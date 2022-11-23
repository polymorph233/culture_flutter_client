
import 'dart:math';

import 'package:culture_flutter_client/models/festival.dart';
import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:culture_flutter_client/view_models/comment_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_detail_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/widgets/comment_list.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../view_models/main_list_view_model.dart';

class FestivalDetailScreen extends StatefulWidget {

  final FestivalDetailViewModel viewModel;

  const FestivalDetailScreen({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => FestivalDetailScreenState();
}

class FestivalDetailScreenState extends State<FestivalDetailScreen> {

  Future<List<CommentViewModel>> loadComments() async {
    final cmts = await DummyService.commentsOf(widget.viewModel.id);
    return cmts.map((e) => CommentViewModel(e)).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final table = DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Attribute',
              style: TextStyle(color: Colors.transparent),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Value',
              style: TextStyle(color: Colors.transparent),
            ),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Period')),
            DataCell(Text(widget.viewModel.festival.principalPeriod)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Size')),
            DataCell(Text(widget.viewModel.festival.territorialSize == null ? "unknown" : festivalToString(widget.viewModel.festival.territorialSize!))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('City')),
            DataCell(Text(widget.viewModel.festival.principalCommune)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('County')),
            DataCell(Text(widget.viewModel.festival.principalDepartment)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('State')),
            DataCell(Text(widget.viewModel.festival.principalRegion)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('zipCode')),
            DataCell(Text(widget.viewModel.festival.zipCode?.toString() ?? "unknown")),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Website')),
            DataCell(Text(widget.viewModel.festival.officialSite ?? "unknown")),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('State')),
            DataCell(Text(widget.viewModel.festival.principalRegion)),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.viewModel.festival.name)
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Expanded(
            child:
              table
          ),
          FutureBuilder<List<CommentViewModel>>(
            future: loadComments(),
            builder: (BuildContext context, AsyncSnapshot<List<CommentViewModel>> commentsFuture) {
              if (commentsFuture.hasData && commentsFuture.data != null) {
                return Expanded(
                    child: CommentList(comments: commentsFuture.data!, scrollController: ScrollController()));
              } else {
                return const Text("Comment is loading, please wait...");
              }
            },
          ),
        ]
      )
    ));
  }
}


class FestivalDetailEntry extends StatefulWidget {
  const FestivalDetailEntry({super.key, required this.id});
  
  final int id;

  @override
  State<FestivalDetailEntry> createState() => _FestivalDetailEntryState();
}

class _FestivalDetailEntryState extends State<FestivalDetailEntry> {

  @override
  Widget build(BuildContext context) {
    
    final viewModel = Provider.of<MainListViewModel>(context);
    
    final festivalVM = viewModel.festivals[widget.id];

    final detailedViewModel = FestivalDetailViewModel(widget.id, festivalVM);

    final fabIcons = [
      FloatingActionButton.small(
        tooltip: "Share",
        heroTag: "shareBtn",
        child: const Icon(Icons.share),
        onPressed: () async =>
          await
            Share.share("Here is my favorite culture festival:\n${festivalVM.name}, let's discuss on app: https://www.amazingfestivals.com/connect?invite=${generateRandomString(25)} .")
      ),
      FloatingActionButton.small(
        tooltip: "Home",
        heroTag: "welcomeBtn",
        child: const Icon(Icons.home),
        onPressed: () => context.go("/"),
      ),
      FloatingActionButton.small(
        tooltip: "List",
        heroTag: "listBtn",
        child: const Icon(Icons.list),
        onPressed: () => context.go("/list"),
      ),
      FloatingActionButton.small(
        tooltip: "Map",
        heroTag: "mapBtn",
        child: const Icon(Icons.map),
        onPressed: () => context.go("/map"),
      ),
      FloatingActionButton.small(
        tooltip: "Favorites",
        heroTag: "favBtn",
        child: const Icon(Icons.favorite),
        onPressed: () => context.go("/fav"),
      ),
    ];

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => detailedViewModel,
        child: FestivalDetailScreen(viewModel: detailedViewModel),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 60,
        children:
         fabIcons
      ));
  }
}

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}