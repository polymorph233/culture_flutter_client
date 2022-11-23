// ViewModel

import 'package:osm_nominatim/osm_nominatim.dart';

import '../models/festival.dart';

class FestivalViewModel {
  final Festival model;

  final int id;

  FestivalViewModel({required this.id, required this.model});

  String get name {
    return model.name;
  }

  TerritorialSize? get territorialSize {
    return model.territorialSize;
  }

  String get principalRegion {
    return model.principalRegion;
  }

  String get principalDepartment {
    return model.principalDepartment;
  }

  String get principalCommune {
    return model.principalCommune;
  }

  String get principalPeriod {
    return model.principalPeriod;
  }

  String? get officialSite {
    return model.officialSite;
  }

  int? get zipCode {
    return model.zipCode;
  }

  int get inseeCode {
    return model.inseeCode;
  }

  Place? get place {
    return model.place;
  }
}