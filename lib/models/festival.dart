// Model

// Data structure from OpenData, to be replaced by the Firebase API facet

import 'package:osm_nominatim/osm_nominatim.dart';

enum TerritorialSize {
  communal, intercommunal, departmental, interdepartmental, regional, interregional, national, crossBorder
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

  // And other fields...

  Festival({required this.name, this.territorialSize, required this.principalRegion, required this.principalDepartment, required this.principalCommune, required this.principalPeriod, this.officialSite, this.zipCode, required this.inseeCode, this.place});

}