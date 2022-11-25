// Model

// Data structure from OpenData, to be replaced by the Firebase API facet

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

enum TerritorialSize {
  communal, intercommunal, departmental, interdepartmental, regional, interregional, national, crossBorder
}

enum Domain {
  visualNumericArts, cinema, literature, music, pluridiscipline, liveScene,
}

Domain toDomain(String value) {
  switch (value) {
    case 'Arts visuels, arts numériques': return Domain.visualNumericArts;
    case 'Cinéma, audiovisuel': return Domain.cinema;
    case 'Livre, littérature': return Domain.literature;
    case 'Musique': return Domain.music;
    case 'Pluridisciplinaire': return Domain.pluridiscipline;
    case 'Spectacle vivant': return Domain.liveScene;
    default: throw Exception("Bad domain type encountered");
  }
}

IconData categoryIcon(Domain domain) {
  switch (domain) {
    case Domain.visualNumericArts: return Icons.palette;
    case Domain.cinema: return Icons.theaters;
    case Domain.literature: return Icons.auto_stories;
    case Domain.music: return Icons.music_note;
    case Domain.pluridiscipline: return Icons.hub;
    case Domain.liveScene: return Icons.theater_comedy;
  }
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
  final String? principalRegion;
  final String? principalDepartment;
  final String? principalCommune;
  final String? principalPeriod;
  final String? officialSite;
  final int? zipCode;
  final String? inseeCode;
  final LatLng? latLng;
  final Domain domain;

  // And other fields...

  Festival({required this.name, this.territorialSize, required this.principalRegion, required this.principalDepartment, required this.principalCommune, required this.principalPeriod, this.officialSite, this.zipCode, required this.inseeCode, required this.domain, this.latLng});

  static Festival fromFirebase(Map<dynamic, dynamic> snapshot) {

    dynamic geo = snapshot["fields"]?["geolocalisation"];
    LatLng? latLng;
    if (geo != null) {
      latLng = LatLng(geo[0], geo[1]);
    }

    return Festival(
        name: snapshot["fields"]["nom_du_festival"],
        principalRegion: snapshot["fields"]['region_principale_de_deroulement'],
        principalDepartment: snapshot["fields"]['departement_principal_de_deroulement'],
        principalCommune: snapshot["fields"]['commune_principale_de_deroulement'],
        principalPeriod:  snapshot["fields"]['periode_principale_de_deroulement_du_festival'],
        inseeCode:  snapshot["fields"]['code_insee_commune'],
        domain:  toDomain(snapshot["fields"]['discipline_dominante']),
        latLng: latLng,
    );
  }
}