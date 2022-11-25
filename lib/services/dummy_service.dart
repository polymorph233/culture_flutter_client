import 'package:culture_flutter_client/models/comment.dart';
import 'package:culture_flutter_client/models/festival.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import '../view_models/festival_view_model.dart';

class FestivalData {
  final String name;
  final TerritorialSize? territorialSize;
  final String principalRegion;
  final String principalDepartment;
  final String principalCommune;
  final String principalPeriod;
  final String? officialSite;
  final int? zipCode;
  final String inseeCode;
  final String? geoLocation;
  final Domain domain;
  // And other fields...

  FestivalData({required this.name, this.territorialSize, required this.principalRegion, required this.principalDepartment, required this.principalCommune, required this.principalPeriod, this.officialSite, this.zipCode, required this.inseeCode, required this.domain, this.geoLocation});

  Future<Festival> toFestival() async {
    List<Place> place = [];
    LatLng? _latLng;
    if (geoLocation != null) {
      final latLng = geoLocation?.split(",").map((e) => double.parse(e)).toList();

      if (latLng != null) {
        _latLng = LatLng(latLng[0], latLng[1]);
      }
    }
    return Festival(
        name: name, principalRegion: principalRegion, territorialSize: territorialSize, principalDepartment: principalDepartment, principalCommune: principalCommune, principalPeriod: principalPeriod, officialSite: this.officialSite, zipCode: this.zipCode, inseeCode: inseeCode,
        latLng: _latLng,
        domain: domain,
    );
  }
}

class DummyService {
  static List<FestivalData> queue = <FestivalData>[
    FestivalData(name: "Alphapodis", territorialSize: TerritorialSize.departmental, principalRegion: "Normandie", principalDepartment: "Orne", principalCommune: "Alençon", principalPeriod: "Avant-saison (1er janvier - 20 juin)", officialSite: "www.alphapodis.fr", zipCode: 61000, inseeCode: "61001", domain: Domain.pluridiscipline, geoLocation: "48.417824,0.101097"),
    FestivalData(name: "World festival Ambert", principalRegion: "Auvergne-Rhône-Alpes", principalDepartment: "Puy-de-Dôme", principalCommune: "Ambert", principalPeriod: "Saison (21 juin - 5 septembre)", officialSite: "https://festival-ambert.fr/", zipCode: 63600, inseeCode: "63003", domain: Domain.cinema, geoLocation: "45.549591,3.745486"),
    FestivalData(name: "Cuivres en Nord", principalRegion: "Hauts-de-France", principalDepartment: "Nord", principalCommune: "Anor", principalPeriod: "Après-saison (6 septembre - 31 décembre)", officialSite: "https://www.cuivresennord.com/", zipCode: 59186, inseeCode: "59012", domain: Domain.visualNumericArts),
    FestivalData(name: "Autres Mesures", principalRegion: "Bretagne", principalDepartment: "Ille-et-Vilaine", principalCommune: "Rennes", principalPeriod: "Avant-saison (1er janvier - 20 juin)", officialSite: "https://autresmesures.wixsite.com", zipCode: 35000, inseeCode: "35238", domain: Domain.music, geoLocation: "48.092601,-1.690824"),
  ];
  
  static Map<int, List<Comment>> comments = {
    0: [
      Comment(author: "David Johnson", star: Star.star3, title: "Not so bad", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget varius lacus, id condimentum quam."),
      Comment(author: "@we50meFêstivàl", star: Star.star4, title: "1t is @we50me", content: "Donec consectetur egestas massa, porttitor posuere nisl vehicula quis."),
      Comment(author: "Springfield Boring", star: Star.star3, title: "Just like my name", content: "Pellentesque at orci lorem. Cras magna mi, imperdiet nec ante sed, hendrerit ornare dui."),
    ],
    1: [
      Comment(author: "Hawkins Rackham", star: Star.star5, title: "Brilliant", content: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga."),
      Comment(author: "NextGenMachineGun", star: Star.star2, title: "Poor experience", content: "In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided."),
    ]
  };

  static final Set<Suggestion> _suggestions = {};

  static Set<Suggestion> suggests() {
    if (_suggestions.isNotEmpty) {
      return _suggestions;
    } else {
      final names = queue.map((e) =>
          Suggestion(icon: Icons.festival_outlined, type: SuggestionType.festival, present: e.name, content: e.name.toLowerCase())).toSet();
      final regions = queue.map((e) =>
          Suggestion(icon: Icons.map_outlined, type: SuggestionType.region, present: e.principalRegion, content: e.principalRegion.toLowerCase()))
          .toSet();
      final departments = queue.map((e) =>
          Suggestion(icon: Icons.map_rounded, type: SuggestionType.department, present: e.principalDepartment, content: e.principalDepartment.toLowerCase()))
          .toSet();
      final communes = queue.map((e) =>
          Suggestion(icon: Icons.location_city, type: SuggestionType.commune, present: e.principalCommune, content: e.principalCommune.toLowerCase()))
          .toSet();
      final periods = queue.map((e) =>
          Suggestion(icon: Icons.date_range, type: SuggestionType.period, present: e.principalPeriod, content: e.principalPeriod.toLowerCase()))
          .toSet();
      _suggestions.addAll(names);
      _suggestions.addAll(regions);
      _suggestions.addAll(departments);
      _suggestions.addAll(communes);
      _suggestions.addAll(periods);
      _suggestions.addAll([
        Suggestion(icon: Icons.music_note, type: SuggestionType.domain, present: "Music", content: "music"),
        Suggestion(icon: Icons.theaters, type: SuggestionType.domain, present: "Cinema", content: "cinema"),
        Suggestion(icon: Icons.auto_stories, type: SuggestionType.domain, present: "Literature", content: "literature"),
        Suggestion(icon: Icons.theater_comedy, type: SuggestionType.domain, present: "Live Scene", content: "live scene"),
        Suggestion(icon: Icons.palette, type: SuggestionType.domain, present: "Visual Numeric Arts", content: "visual numeric arts"),
        Suggestion(icon: Icons.hub, type: SuggestionType.domain, present: "Pluridiscipline", content: "pluridiscipline"),
      ]);
      return _suggestions;
    }
  }


  static Future<List<Festival>> fetch() async {
     return await Future.wait(queue.map((e) async => await e.toFestival()));
  }

  static Future<List<Comment>> commentsOf(int index) async {
    return comments[index] ?? [];
  }

  List<FestivalViewModel> favorites = [];

  void setFavorites(List<FestivalViewModel> favorites) {
    this.favorites = favorites;
  }
}

enum SuggestionType {
  rawName, festival, region, department, commune, period, domain,
}

class Suggestion {
  final IconData icon;
  final SuggestionType type;
  final String present;
  final String content;

  Suggestion({required this.icon, required this.type, required this.present, required this.content});
}