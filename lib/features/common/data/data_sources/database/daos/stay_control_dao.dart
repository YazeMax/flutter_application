import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/stay_control.dart';

class StayControlDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "stay_controls";

  Future create(StayControlModel stayControl) async {
    await _instance
        .collection(_collection)
        .doc(stayControl.id.toString())
        .set(stayControl.toMap());
  }

  Future<StayControlModel?> read(int stayControlId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(stayControlId.toString())
        .get();
    return StayControlModel.fromMap(snapshot.data()!);
  }

  Future<List<StayControlModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => StayControlModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(StayControlModel stayControl) async {
    await _instance
        .collection(_collection)
        .doc(stayControl.id.toString())
        .update(stayControl.toMap());
  }

  Future replace(StayControlModel stayControl) async {
    await _instance
        .collection(_collection)
        .doc(stayControl.id.toString())
        .set(stayControl.toMap());
  }

  Future delete(int stayControlId) async {
    await _instance
        .collection(_collection)
        .doc(stayControlId.toString())
        .delete();
  }
}
