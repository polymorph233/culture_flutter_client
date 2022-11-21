import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FestivalList extends StatelessWidget {

  final List<FestivalViewModel> festivals;

  final ScrollController scrollController;

  const FestivalList({super.key, required this.festivals, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: festivals.length,
        controller: scrollController,
        itemBuilder: (context, index) {

          final item = festivals[index];

          return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(item.name.substring(0, 2)),
                ),
                title: Text(item.name),
                subtitle: Text(item.principalPeriod),
              ));
        });
  }
}