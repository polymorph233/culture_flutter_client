import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../packages/text_cursor/text_cursor.dart';

class SearchBox extends StatefulWidget {

  final ValueChanged<String> onTapped;
  final ValueChanged<List<String>> onChanged;

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
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'keyword search'),
                findSuggestions: _findSuggestions,
                onChanged: (values) => _onChanged(values.map((e) => e.content).toList()),
                chipBuilder: (BuildContext context, ChipsInputState<Suggestion> state, Suggestion suggest) {
                  return InputChip(
                    key: ObjectKey(suggest),
                    label:
                      FittedBox(child: Row(children: [Icon(suggest.icon), Text(suggest.content)])),
                    // avatar: CircleAvatar(
                    //   backgroundImage: NetworkImage(keyword),
                    // ),
                    onDeleted: () => state.deleteChip(suggest),
                    onSelected: (_) => _onChipTapped(suggest.content),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (BuildContext context, ChipsInputState<Suggestion> state, Suggestion suggest) {
                  return ListTile(
                    key: ObjectKey(suggest),
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(keyword.imageUrl),
                    // ),
                    title: Row(children: [Icon(suggest.icon), Text(suggest.content)]),
                    // subtitle: Text(keyword.email),
                    onTap: () => state.selectSuggestion(suggest),
                  );
                },
              ),
            ),
          ),
        ]);
  }

  void _onChipTapped(String keyword) {
    widget.onTapped(keyword);
    print(keyword);
  }

  void _onChanged(List<String> data) {
    widget.onChanged(data);
    print('onChanged $data');
  }

  Future<List<Suggestion>> _findSuggestions(String query) async {
    if (query.isNotEmpty) {
      final results = mockResults.where((suggest) {
        return suggest.content.contains(query)  /* || keyword.contains(query) */;
      }).toList(growable: false);
      return [Suggestion(icon: Icons.text_snippet_outlined, content: query)] + results;
    } else {
      return [];
    }
  }

  Set<Suggestion> get mockResults => DummyService.suggests();
}
