import 'package:culture_flutter_client/models/festival.dart';

class DummyService {
  static List<Festival> queue = <Festival>[
    Festival(name: "Alphapodis", territorialSize: TerritorialSize.departmental, principalRegion: "Normandie", principalDepartment: "Orne", principalCommune: "Alençon", principalPeriod: "Avant-saison (1er janvier - 20 juin)", officialSite: "www.alphapodis.fr", zipCode: 61000, inseeCode: 61001),
    Festival(name: "World festival Ambert", principalRegion: "Auvergne-Rhône-Alpes", principalDepartment: "Puy-de-Dôme", principalCommune: "Ambert", principalPeriod: "Saison (21 juin - 5 septembre)", officialSite: "https://festival-ambert.fr/", zipCode: 63600, inseeCode: 63003),
    Festival(name: "Cuivres en Nord", principalRegion: "Hauts-de-France", principalDepartment: "Nord", principalCommune: "Anor", principalPeriod: "Après-saison (6 septembre - 31 décembre)", officialSite: "https://www.cuivresennord.com/", zipCode: 59186, inseeCode: 59012),
  ];

  static Future<List<Festival>> fetch() async {
    return queue;
  }
}