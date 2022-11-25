import 'package:culture_flutter_client/services/utils.dart';
import 'package:culture_flutter_client/view_models/festival_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:collection/collection.dart';

import '../models/festival.dart';

class FirebaseConnector {
  static final DatabaseReference _festivalRefNode = FirebaseDatabase.instance.ref("/festival");

  static void readWithAction(void Function(DatabaseEvent) action) async {
    _festivalRefNode.onValue.listen((event) => action(event));
  }

  static Future<List<FestivalViewModel>> fetchDB() async {
    final ref = FirebaseDatabase.instance.ref("/festivals");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      try {
        return snapshot.children
            .map((fest) {
          final out = Festival.fromFirebase(
              fest.value as Map<dynamic, dynamic>);
          return out;
        })
            .mapIndexed((i, model) {
          return FestivalViewModel(id: i, model: model);
        }).toList();
      } on Exception catch (e) {
        Utils.showSnackBar("Something went wrong");
        rethrow;
      }
    } else {
      Utils.showSnackBar("Something went wrong");
      throw Exception("Failed to get database");
    }
  }
}