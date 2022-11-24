import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import 'festival_view_model.dart';

class FestivalListViewModel extends ChangeNotifier {

  List<FestivalViewModel> festivals = <FestivalViewModel>[];

  Future<void> update() async {
    // TODO: Update festival list from remote
    final results = await DummyService.fetch();
    festivals = results.mapIndexed((i, e) => FestivalViewModel(id: i, model: e)).toList();
    notifyListeners();
  }

  bool get isEmpty => festivals.isEmpty;

  List<FestivalViewModel> randomFestivals(int count) {
    if (festivals.isEmpty) {
      update();
    }
    List<FestivalViewModel> copyOfFestivals = List.from(festivals);
    copyOfFestivals.shuffle();
    if (count > copyOfFestivals.length) {
      return copyOfFestivals;
    } else {
      return copyOfFestivals.take(count).toList();
    }
  }
}