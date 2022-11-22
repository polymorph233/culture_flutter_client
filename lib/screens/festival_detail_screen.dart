
import 'package:culture_flutter_client/view_models/favorite_festival_list_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_detail_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_list_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/widgets/comment_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../widgets/festival_list.dart';

class FestivalDetailScreen extends StatelessWidget {
  const FestivalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FestivalDetailViewModel>(context);

    List<String> _infoList = [
      vm.festival.officialSite ?? "official site unavailable",
      "zipcode: ${vm.festival.zipCode.toString()}",
      "insee code: ${vm.festival.inseeCode}",
    ];

    final GlobalKey<ChipsInputState> _chipKey = GlobalKey();

    const helperStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w200);
    const keyStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const mainStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

    return Scaffold(
      appBar: AppBar(
          title: Text(vm.festival.name)
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(10),
            child:
              Column(children: [
                Title(color: Colors.black, child: Text(vm.festival.name)),
                const Text("during period", style: helperStyle),
                Text(vm.festival.principalPeriod, style: keyStyle),
                const Text("in", style: helperStyle),
                Text(vm.festival.principalCommune, style: keyStyle),
                Text(vm.festival.principalDepartment, style: keyStyle),
                Text(vm.festival.principalRegion, style: keyStyle),
                const Spacer(),
                ListView.builder(
                    itemCount: _infoList.length,
                    controller: ScrollController(),
                    itemBuilder: (context, index) {

                      final item = _infoList[index];
                      return Text(item, style: mainStyle);
                    }),
              ])
          ),
          Expanded(
              child: CommentList(comments: vm.comments, scrollController: ScrollController())),
        ]),
      )
    );
  }
}


class FestivalDetailEntry extends StatefulWidget {
  const FestivalDetailEntry({super.key, required this.festivalDetailViewModel});

  final FestivalDetailViewModel festivalDetailViewModel;

  String get title => festivalDetailViewModel.festival.name;

  @override
  State<FestivalDetailEntry> createState() => _FestivalDetailEntryState();
}

class _FestivalDetailEntryState extends State<FestivalDetailEntry> {

  FestivalDetailViewModel get festivalDetailViewModel => widget.festivalDetailViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => festivalDetailViewModel,
        child: const FestivalDetailScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'TODO',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
