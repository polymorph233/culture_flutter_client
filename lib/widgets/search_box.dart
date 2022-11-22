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
              child: ChipsInput<String>(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'keyword search'),
                findSuggestions: _findSuggestions,
                onChanged: _onChanged,
                chipBuilder: (BuildContext context, ChipsInputState<String> state, String keyword) {
                  return InputChip(
                    key: ObjectKey(keyword),
                    label: Text(keyword),
                    // avatar: CircleAvatar(
                    //   backgroundImage: NetworkImage(keyword),
                    // ),
                    onDeleted: () => state.deleteChip(keyword),
                    onSelected: (_) => _onChipTapped(keyword),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (BuildContext context, ChipsInputState<String> state, String keyword) {
                  return ListTile(
                    key: ObjectKey(keyword),
                    // leading: CircleAvatar(
                    //   backgroundImage: NetworkImage(keyword.imageUrl),
                    // ),
                    title: Text(keyword),
                    // subtitle: Text(keyword.email),
                    onTap: () => state.selectSuggestion(keyword),
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

  Future<List<String>> _findSuggestions(String query) async {
    if (query.length != 0) {
      return mockResults.where((keyword) {
        return keyword.contains(query)  /* || keyword.contains(query) */;
      }).toList(growable: false);
    } else {
      return [query];
    }
  }

  List<String> get mockResults => [
    "Alphapodis", "World festival Ambert", "Cuivres en Nord"
  ];
}
