import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_activity.dart';

class VolunteerActivityDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "volunteer_activities";

  Future create(VolunteerActivityModel volunteerActivity) async {
    await _instance
        .collection(_collection)
        .doc(volunteerActivity.id.toString())
        .set(volunteerActivity.toMap());
  }

  Future<VolunteerActivityModel?> read(int volunteerActivityId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(volunteerActivityId.toString())
        .get();
    return VolunteerActivityModel.fromMap(snapshot.data()!);
  }

  Future<List<VolunteerActivityModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => VolunteerActivityModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(VolunteerActivityModel volunteerActivity) async {
    await _instance
        .collection(_collection)
        .doc(volunteerActivity.id.toString())
        .update(volunteerActivity.toMap());
  }

  Future replace(VolunteerActivityModel volunteerActivity) async {
    await _instance
        .collection(_collection)
        .doc(volunteerActivity.id.toString())
        .set(volunteerActivity.toMap());
  }

  Future delete(int volunteerActivityId) async {
    await _instance
        .collection(_collection)
        .doc(volunteerActivityId.toString())
        .delete();
  }
}
