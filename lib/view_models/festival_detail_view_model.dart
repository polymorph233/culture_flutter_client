import './comment_view_model.dart';
import './festival_view_model.dart';

class FestivalDetailViewModel {
  final FestivalViewModel festival;
  final List<CommentViewModel> comments = [];

  FestivalDetailViewModel(this.festival);
}