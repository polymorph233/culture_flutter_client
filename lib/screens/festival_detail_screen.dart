
import 'package:culture_flutter_client/models/festival.dart';
import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:culture_flutter_client/view_models/festival_detail_view_model.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:culture_flutter_client/widgets/comment_list.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

import '../packages/text_cursor/text_cursor.dart';
import '../view_models/main_list_view_model.dart';

class FestivalDetailScreen extends StatelessWidget {
  
  final FestivalDetailViewModel viewModel;
  const FestivalDetailScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    const helperStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w200);
    const keyStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const mainStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

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
            DataCell(Text(viewModel.festival.principalPeriod)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Size')),
            DataCell(Text(viewModel.festival.territorialSize == null ? "unknown" : festivalToString(viewModel.festival.territorialSize!))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('City')),
            DataCell(Text(viewModel.festival.principalCommune)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('County')),
            DataCell(Text(viewModel.festival.principalDepartment)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('State')),
            DataCell(Text(viewModel.festival.principalRegion)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('zipCode')),
            DataCell(Text(viewModel.festival.zipCode?.toString() ?? "unknown")),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('Website')),
            DataCell(Text(viewModel.festival.officialSite ?? "unknown")),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            const DataCell(Text('State')),
            DataCell(Text(viewModel.festival.principalRegion)),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(viewModel.festival.name)
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
          Expanded(
            child: CommentList(comments: viewModel.comments, scrollController: ScrollController())),
        ]),
      )
    );
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
    
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => detailedViewModel,
        child: FestivalDetailScreen(viewModel: detailedViewModel),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.festivalDetail)
    );
  }
}
