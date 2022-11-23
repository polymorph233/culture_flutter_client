import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../models/festival.dart';

class FestivalList extends StatelessWidget {

  final List<FestivalViewModel> festivals;

  final List<FestivalViewModel> favorites;

  final ScrollController scrollController;

  final ValueChanged<FestivalViewModel>? onAdd;

  final ValueChanged<FestivalViewModel>? onDelete;

  final ValueChanged<int> onClick;

  const FestivalList({super.key, required this.festivals, required this.favorites, required this.scrollController,
    this.onAdd, this.onDelete, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: festivals.length,
        controller: scrollController,
        itemBuilder: (context, index) {

          final item = festivals[index];

          return FestivalWidget(festival: item, isLiked: favorites.contains(item), onAdd: onAdd, onDelete: onDelete, onClick: onClick);
        });
  }
}

class FestivalWidget extends StatelessWidget {
  final FestivalViewModel festival;

  final bool isLiked;

  final ValueChanged<FestivalViewModel>? onAdd;

  final ValueChanged<FestivalViewModel>? onDelete;

  final ValueChanged<int> onClick;

  const FestivalWidget({super.key, required this.festival, required this.isLiked, this.onAdd, this.onDelete, required this.onClick});
  
  @override
  Widget build(BuildContext context) {
    Widget card = InkWell(
      onTap: () => onClick(festival.id),
      child: Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(categoryIcon(festival.domain)),
        ),
        title: Text(festival.name),
        subtitle: Text(festival.principalPeriod),
      ),
    ));

    List<Widget> widgets = [Expanded(child: card)];

    if (!isLiked) {
      Widget addIcon = IconButton(
          onPressed: () => onAdd!(festival), icon: const Icon(Icons.favorite_outline));
      widgets.add(addIcon);
    } else {
      Widget removeIcon = IconButton(
          onPressed: () => onDelete!(festival), icon: const Icon(Icons.favorite));
      widgets.add(removeIcon);
    }
    if (onAdd != null || onDelete != null) {
      return Row(children: widgets);
    } else {
      return card;
    }
  }
}