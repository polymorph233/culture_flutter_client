import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:flutter/widgets.dart';

import './comment_view_model.dart';
import './festival_view_model.dart';

class FestivalDetailViewModel extends ChangeNotifier {
  final int id;
  final FestivalViewModel festival;
  List<CommentViewModel> comments = [];

  FestivalDetailViewModel(this.id, this.festival,) {
    DummyService.commentsOf(id).then((value) => comments = value.map((e) => CommentViewModel(e)).toList());
  }
}