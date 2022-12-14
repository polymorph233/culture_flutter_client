
class Department {
  final String code;
  final String name;

  Department({required this.code, required this.name});

  static List<Department> allDepartments = [
    Department(code: "1", name: "Ain"),
    Department(code: "2", name: "Aisne"),
    Department(code: "3", name: "Allier"),
    Department(code: "4", name: "Alpes-de-Haute-Provence"),
    Department(code: "5", name: "Hautes-Alpes"),
    Department(code: "6", name: "Alpes-Maritimes"),
    Department(code: "7", name: "Ardèche"),
    Department(code: "8", name: "Ardennes"),
    Department(code: "9", name: "Ariège"),
    Department(code: "10", name: "Aube"),
    Department(code: "11", name: "Aude"),
    Department(code: "12", name: "Aveyron"),
    Department(code: "13", name: "Bouches-du-Rhône"),
    Department(code: "14", name: "Calvados"),
    Department(code: "15", name: "Cantal"),
    Department(code: "16", name: "Charente"),
    Department(code: "17", name: "Charente-Maritime"),
    Department(code: "18", name: "Cher"),
    Department(code: "19", name: "Corrèze"),
    Department(code: "21", name: "Côte-d'Or"),
    Department(code: "22", name: "Côtes-d'Armor"),
    Department(code: "23", name: "Creuse"),
    Department(code: "24", name: "Dordogne"),
    Department(code: "25", name: "Doubs"),
    Department(code: "26", name: "Drôme"),
    Department(code: "27", name: "Eure"),
    Department(code: "28", name: "Eure-et-Loire"),
    Department(code: "29", name: "Finistère"),
    Department(code: "30", name: "Gard"),
    Department(code: "31", name: "Haute-Garonne"),
    Department(code: "32", name: "Gers"),
    Department(code: "33", name: "Gironde"),
    Department(code: "34", name: "Hérault"),
    Department(code: "35", name: "Ille-et-Vilaine"),
    Department(code: "36", name: "Indre"),
    Department(code: "37", name: "Indre-et-Loire"),
    Department(code: "38", name: "Isère"),
    Department(code: "39", name: "Jura"),
    Department(code: "40", name: "Landes"),
    Department(code: "41", name: "Loir-et-Cher"),
    Department(code: "42", name: "Loire"),
    Department(code: "43", name: "Haute-Loire"),
    Department(code: "44", name: "Loire-Atlantique"),
    Department(code: "45", name: "Loiret"),
    Department(code: "46", name: "Lot"),
    Department(code: "47", name: "Lot-et-Garonne"),
    Department(code: "48", name: "Lozère"),
    Department(code: "49", name: "Maine-et-Loire"),
    Department(code: "50", name: "Manche"),
    Department(code: "51", name: "Marne"),
    Department(code: "52", name: "Haute-Marne"),
    Department(code: "53", name: "Mayenne"),
    Department(code: "54", name: "Meurthe-et-Moselle"),
    Department(code: "55", name: "Meuse"),
    Department(code: "56", name: "Morbihan"),
    Department(code: "57", name: "Moselle"),
    Department(code: "58", name: "Nièvre"),
    Department(code: "59", name: "Nord"),
    Department(code: "60", name: "Oise"),
    Department(code: "61", name: "Orne"),
    Department(code: "62", name: "Pas-de-Calais"),
    Department(code: "63", name: "Puy-de-Dôme"),
    Department(code: "64", name: "Pyrénées-Atlantiques"),
    Department(code: "65", name: "Hautes-Pyrénées"),
    Department(code: "66", name: "Pyrénées-Orientales"),
    Department(code: "67", name: "Bas-Rhin"),
    Department(code: "68", name: "Haut-Rhin"),
    Department(code: "69", name: "Rhône"),
    Department(code: "70", name: "Haute-Saône"),
    Department(code: "71", name: "Saône-et-Loire"),
    Department(code: "72", name: "Sarthe"),
    Department(code: "73", name: "Savoie"),
    Department(code: "74", name: "Haute-Savoie"),
    Department(code: "75", name: "Paris"),
    Department(code: "76", name: "Seine-Maritime"),
    Department(code: "77", name: "Seine-et-Marne"),
    Department(code: "78", name: "Yvelines"),
    Department(code: "79", name: "Deux-Sèvres"),
    Department(code: "80", name: "Somme"),
    Department(code: "81", name: "Tarn"),
    Department(code: "82", name: "Tarn-et-Garonne"),
    Department(code: "83", name: "Var"),
    Department(code: "84", name: "Vaucluse"),
    Department(code: "85", name: "Vendée"),
    Department(code: "86", name: "Vienne"),
    Department(code: "87", name: "Haute-Vienne"),
    Department(code: "88", name: "Vosges"),
    Department(code: "89", name: "Yonne"),
    Department(code: "90", name: "Territoire de Belfort"),
    Department(code: "91", name: "Essonne"),
    Department(code: "92", name: "Hauts-de-Seine"),
    Department(code: "93", name: "Seine-Saint-Denis"),
    Department(code: "94", name: "Val-de-Marne"),
    Department(code: "95", name: "Val-d'Oise"),
    Department(code: "971", name: "Guadeloupe"),
    Department(code: "972", name: "Martinique"),
    Department(code: "973", name: "Guyane"),
    Department(code: "974", name: "La Réunion"),
    Department(code: "976", name: "Mayotte"),
    Department(code: "2A", name: "Corse-du-Sud"),
    Department(code: "2B", name: "Haute-Corse"),
  ];

  static bool isValidFrenchDepartment(String input) {
    return allDepartments.any((element) => element.name == input || element.code == input);
  }
}


