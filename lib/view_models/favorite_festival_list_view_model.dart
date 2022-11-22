import 'package:flutter/widgets.dart';

import 'festival_view_model.dart';
import 'i_festival_list_view_model.dart';

class FavoriteFestivalListViewModel extends ChangeNotifier implements IFestivalListViewModel {

  @override
  List<FestivalViewModel> festivals = <FestivalViewModel>[];

  List<FestivalViewModel> get favorites => festivals;

  set favorites(List<FestivalViewModel> value) => festivals = value;

  void addFestival(FestivalViewModel fest) {
    festivals.add(fest);
  }

  void removeFestival(FestivalViewModel fest) {
    festivals.remove(fest);
  }
}