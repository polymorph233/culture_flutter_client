import 'package:flutter/widgets.dart';

import './comment_view_model.dart';
import './festival_view_model.dart';

class FestivalDetailViewModel extends ChangeNotifier {
  final FestivalViewModel festival;
  final List<CommentViewModel> comments = [];

  FestivalDetailViewModel(this.festival);
}