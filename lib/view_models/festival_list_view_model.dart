import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:flutter/cupertino.dart';

import 'festival_view_model.dart';

class FestivalListViewModel extends ChangeNotifier {
  List<FestivalViewModel> festivals = <FestivalViewModel>[];

  Future<void> update() async {
    // TODO: Update festival list from remote
    final results = await DummyService.fetch();
    festivals = results.map((e) => FestivalViewModel(model: e)).toList();
    notifyListeners();
  }

  Future<void> updateAnimated(ScrollController scrollController) async {
    update();
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

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