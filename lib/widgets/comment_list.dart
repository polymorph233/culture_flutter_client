import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/comment.dart';
import '../view_models/comment_view_model.dart';

class CommentList extends StatelessWidget {

  final List<CommentViewModel> comments;

  final ScrollController scrollController;

  const CommentList({super.key, required this.comments, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        final item = comments[index];
        return CommentWidget(item: item);
      });
  }
}

class CommentWidget extends StatelessWidget {
  final CommentViewModel item;

  const CommentWidget({super.key, required this.item});

  List<Widget> get _star {
    int count = 0;

    switch (item.comment.star) {
      case Star.star1: count = 1; break;
      case Star.star2: count = 2; break;
      case Star.star3: count = 3; break;
      case Star.star4: count = 4; break;
      case Star.star5: count = 5; break;
    }

    const icon = Icon(Icons.star, size: 16,);

    return
      List.filled(count, icon);
  }

  Widget get _title {
    if (item.comment.title == null) {
      return const Text("No title");
    } else {
      return Text(item.comment.title!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.comment),
                title: _title,
                subtitle: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("author: ${item.comment.author}", textAlign: TextAlign.left,), Row(children: _star)]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Preview'),
                    onPressed: () {/* TODO. */},
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('React'),
                    onPressed: () {/* TODO. */},
                  ),
                  const SizedBox(width: 8),
                ],
              )
            ]
        ));
  }
}