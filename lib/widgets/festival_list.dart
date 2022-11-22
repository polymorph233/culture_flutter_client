import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FestivalList extends StatelessWidget {

  final List<FestivalViewModel> festivals;

  final ScrollController scrollController;

  final ValueChanged<FestivalViewModel>? onAdd;

  final ValueChanged<FestivalViewModel>? onDelete;

  const FestivalList({super.key, required this.festivals, required this.scrollController,
    this.onAdd, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: festivals.length,
        controller: scrollController,
        itemBuilder: (context, index) {

          final item = festivals[index];

          if (this.onAdd != null && this.onDelete != null) {
            return FestivalWidget(festival: item, onAdd: onAdd, onDelete: onDelete,);
          } else {
            return FestivalWidget(festival: item);
          }
        });
  }
}

class FestivalWidget extends StatelessWidget {
  final FestivalViewModel festival;

  final ValueChanged<FestivalViewModel>? onAdd;

  final ValueChanged<FestivalViewModel>? onDelete;

  const FestivalWidget({super.key, required this.festival, this.onAdd, this.onDelete});

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(festival.name.substring(0, 2)),
          ),
          title: Text(festival.name),
          subtitle: Text(festival.principalPeriod),
        ));

    List<Widget> widgets = [Expanded(child: card)];

    if (onAdd != null) {
      Widget addIcon = IconButton(
        onPressed: () => onAdd!(festival), icon: const Icon(Icons.add));
      widgets.add(addIcon);
    }
    if (onDelete != null) {
      Widget removeIcon = IconButton(
        onPressed: () => onDelete!(festival), icon: const Icon(Icons.remove));
      widgets.add(removeIcon);
    }
    if (onAdd != null && onDelete != null) {
      return Row(children: widgets);
    } else {
      return card;
    }
  }
}