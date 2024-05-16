import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_process.dart';

class VolunteerProcessDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "volunteer_processes";

  Future create(VolunteerProcessModel volunteerProcess) async {
    await _instance
        .collection(_collection)
        .doc(volunteerProcess.id.toString())
        .set(volunteerProcess.toMap());
  }

  Future<VolunteerProcessModel?> read(int volunteerProcessId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(volunteerProcessId.toString())
        .get();
    return VolunteerProcessModel.fromMap(snapshot.data()!);
  }

  Future<List<VolunteerProcessModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => VolunteerProcessModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(VolunteerProcessModel volunteerProcess) async {
    await _instance
        .collection(_collection)
        .doc(volunteerProcess.id.toString())
        .update(volunteerProcess.toMap());
  }

  Future replace(VolunteerProcessModel volunteerProcess) async {
    await _instance
        .collection(_collection)
        .doc(volunteerProcess.id.toString())
        .set(volunteerProcess.toMap());
  }

  Future delete(int volunteerProcessId) async {
    await _instance
        .collection(_collection)
        .doc(volunteerProcessId.toString())
        .delete();
  }
}
