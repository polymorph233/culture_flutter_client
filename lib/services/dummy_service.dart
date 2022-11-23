import 'package:culture_flutter_client/models/comment.dart';
import 'package:culture_flutter_client/models/festival.dart';
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
  final int inseeCode;
  final int? streetCode;
  final String? streetType;
  final String? streetName;
  final String? addressComplement;
  // And other fields...

  FestivalData({required this.name, this.territorialSize, required this.principalRegion, required this.principalDepartment, required this.principalCommune, required this.principalPeriod, this.officialSite, this.zipCode, required this.inseeCode, this.streetCode, this.streetType, this.streetName, this.addressComplement,});

  Future<Festival> toFestival() async {
    List<Place> place = [];
    if (streetName != null) {
      final searchQuery = "${addressComplement ?? ""} ${streetCode?.toString() ?? ""} ${streetType ?? ""} $streetName";
      place = await Nominatim.searchByName(street: searchQuery, city: principalCommune, county: principalDepartment, state: principalRegion, country: "France", postalCode: zipCode?.toString() ?? "", limit: 1);
    }
    return Festival(
        name: name, principalRegion: principalRegion, territorialSize: territorialSize, principalDepartment: principalDepartment, principalCommune: principalCommune, principalPeriod: principalPeriod, officialSite: this.officialSite, zipCode: this.zipCode, inseeCode: inseeCode,
        place: place.isEmpty ? null : place.first
    );
  }
}

class DummyService {
  static List<FestivalData> queue = <FestivalData>[
    FestivalData(name: "Alphapodis", territorialSize: TerritorialSize.departmental, principalRegion: "Normandie", principalDepartment: "Orne", principalCommune: "Alençon", principalPeriod: "Avant-saison (1er janvier - 20 juin)", officialSite: "www.alphapodis.fr", zipCode: 61000, inseeCode: 61001),
    FestivalData(name: "World festival Ambert", principalRegion: "Auvergne-Rhône-Alpes", principalDepartment: "Puy-de-Dôme", principalCommune: "Ambert", principalPeriod: "Saison (21 juin - 5 septembre)", officialSite: "https://festival-ambert.fr/", zipCode: 63600, inseeCode: 63003),
    FestivalData(name: "Cuivres en Nord", principalRegion: "Hauts-de-France", principalDepartment: "Nord", principalCommune: "Anor", principalPeriod: "Après-saison (6 septembre - 31 décembre)", officialSite: "https://www.cuivresennord.com/", zipCode: 59186, inseeCode: 59012),
    FestivalData(name: "Autres Mesures", principalRegion: "Bretagne", principalDepartment: "Ille-et-Vilaine", principalCommune: "Rennes", principalPeriod: "Avant-saison (1er janvier - 20 juin)", officialSite: "https://autresmesures.wixsite.com", zipCode: 35000, inseeCode: 35238, streetName: "Place de la gare"),
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