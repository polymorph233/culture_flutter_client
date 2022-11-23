// Model

// Data structure from OpenData, to be replaced by the Firebase API facet

import 'package:osm_nominatim/osm_nominatim.dart';

enum TerritorialSize {
  communal, intercommunal, departmental, interdepartmental, regional, interregional, national, crossBorder
}

enum Domain {
  visualNumericArts, cinema, literature, music, pluridiscipline, liveScene,
}

String festivalToString(TerritorialSize ts) {
  switch (ts) {

    case TerritorialSize.communal: return "communal event";
    case TerritorialSize.intercommunal: return "inter-communal event";
    case TerritorialSize.departmental: return "departmental festival";
    case TerritorialSize.interdepartmental: return "inter-departmental festival";
    case TerritorialSize.regional: return "regional festival";
    case TerritorialSize.interregional: return "inter-regional festival";
    case TerritorialSize.national: return "national festival";
    case TerritorialSize.crossBorder: return "international festival";
  }
}

class Festival {
  final String name;
  final TerritorialSize? territorialSize;
  final String principalRegion;
  final String principalDepartment;
  final String principalCommune;
  final String principalPeriod;
  final String? officialSite;
  final int? zipCode;
  final int inseeCode;
  final Place? place;
  final Domain domain;

  // And other fields...

  Festival({required this.name, this.territorialSize, required this.principalRegion, required this.principalDepartment, required this.principalCommune, required this.principalPeriod, this.officialSite, this.zipCode, required this.inseeCode, this.place, required this.domain});

}