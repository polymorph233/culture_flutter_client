import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../packages/text_cursor/text_cursor.dart';

class SearchBox extends StatefulWidget {

  final ValueChanged<Suggestion> onTapped;
  final ValueChanged<List<Suggestion>> onChanged;

  const SearchBox({super.key, required this.onTapped, required this.onChanged});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            // TODO: Add validator
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChipsInput<Suggestion>(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Tap something ...'),
                findSuggestions: _findSuggestions,
                onChanged: (values) => _onChanged(values),
                chipBuilder: (BuildContext context, ChipsInputState<Suggestion> state, Suggestion suggest) {
                  return InputChip(
                    key: ObjectKey(suggest),
                    label:
                      FittedBox(child: Row(children: [Icon(suggest.icon), Text(suggest.present)])),
                    // avatar: CircleAvatar(
                    //   backgroundImage: NetworkImage(keyword),
                    // ),
                    onDeleted: () => state.deleteChip(suggest),
                    onSelected: (_) => _onChipTapped(suggest),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (BuildContext context, ChipsInputState<Suggestion> state, Suggestion suggest) {
                  return ListTile(
                    key: ObjectKey(suggest),
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(keyword.imageUrl),
                    // ),
                    title: Row(children: [Icon(suggest.icon), Text(suggest.present)]),
                    // subtitle: Text(keyword.email),
                    onTap: () => state.selectSuggestion(suggest),
                  );
                },
              ),
            ),
          ),
        ]);
  }

  void _onChipTapped(Suggestion suggest) {
    widget.onTapped(suggest);
    print(suggest);
  }

  void _onChanged(List<Suggestion> data) {
    widget.onChanged(data);
    print('onChanged $data');
  }

  bool validateQuery(String query) {
    return RegExp(r'^[A-Za-z0-9-_ ]+$').hasMatch(query);
  }

  Future<List<Suggestion>> _findSuggestions(String query) async {
    if (validateQuery(query)) {
      final sanit = query.toLowerCase();
      if (sanit.isNotEmpty) {
        final results = mockResults.where((suggest) {
          return suggest.content.contains(
              sanit) /* || keyword.contains(query) */;
        }).toList(growable: false);
        return [Suggestion(icon: Icons.text_snippet_outlined, type: SuggestionType.rawName, present: query, content: sanit)] +
            results;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Set<Suggestion> get mockResults => DummyService.suggests();


}
