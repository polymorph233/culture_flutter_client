
import 'dart:math';

import '../view_models/festival_view_model.dart';

class RecommendFestivalService {
  final List<FestivalViewModel> festivals;
  final List<FestivalViewModel> favorites;

  RecommendFestivalService(this.festivals, this.favorites);

  void analyzeFavorite() {

  }

  List<FestivalViewModel> recommend(int count) {
    List<FestivalViewModel> candidates = [];

    analyzeFavorite();

    if (candidates.isEmpty) {
      Set<int> indices = {};
      while (indices.length < count) {
        indices.add(Random().nextInt(festivals.length));
      }

      candidates.addAll(indices.map((i) => festivals[i]));
    }
    return candidates;
  }
}