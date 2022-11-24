// ViewModel

import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import '../models/festival.dart';
import '../services/dummy_service.dart';

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

  LatLng? get latLng {
    return model.latLng;
  }

  Domain get domain {
    return model.domain;
  }

  static String stringOfDomain(Domain domain) {
    switch (domain) {
      case Domain.visualNumericArts: return "visual numeric arts";
      case Domain.cinema: return "cinema";
      case Domain.literature: return "literature";
      case Domain.music: return "music";
      case Domain.pluridiscipline: return "pluridiscipline";
      case Domain.liveScene: return "live scene";
    }
  }

  static String getLabelBySuggestType(SuggestionType type, FestivalViewModel viewModel) {
    switch (type) {
      case SuggestionType.rawName:
        return "${viewModel.name} ${viewModel.principalRegion} ${viewModel.principalCommune} ${viewModel.principalDepartment} ${viewModel.principalPeriod}";
      case SuggestionType.festival:
        return viewModel.name;
      case SuggestionType.region:
        return viewModel.principalRegion;
      case SuggestionType.department:
        return viewModel.principalDepartment;
      case SuggestionType.commune:
        return viewModel.principalCommune;
      case SuggestionType.period:
        return viewModel.principalPeriod;
      case SuggestionType.domain:
        return FestivalViewModel.stringOfDomain(viewModel.domain);
    }
  }
}

