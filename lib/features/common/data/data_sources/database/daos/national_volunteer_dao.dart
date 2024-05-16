import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/national_volunteer.dart';

class NationalVolunteerDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "national_volunteers";

  Future create(NationalVolunteerModel nationalVolunteer) async {
    await _instance
        .collection(_collection)
        .doc(nationalVolunteer.id.toString())
        .set(nationalVolunteer.toMap());
  }

  Future<NationalVolunteerModel?> read(int nationalVolunteerId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(nationalVolunteerId.toString())
        .get();
    return NationalVolunteerModel.fromMap(snapshot.data()!);
  }

    Future<NationalVolunteerModel?> readByEmail(String email) async {
    final snapshot = await _instance
        .collection(_collection)
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return NationalVolunteerModel.fromMap(snapshot.docs.first.data());
    }
  }

  Future<List<NationalVolunteerModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => NationalVolunteerModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(NationalVolunteerModel nationalVolunteer) async {
    await _instance
        .collection(_collection)
        .doc(nationalVolunteer.id.toString())
        .update(nationalVolunteer.toMap());
  }

  Future replace(NationalVolunteerModel nationalVolunteer) async {
    await _instance
        .collection(_collection)
        .doc(nationalVolunteer.id.toString())
        .set(nationalVolunteer.toMap());
  }

  Future delete(int nationalVolunteerId) async {
    await _instance
        .collection(_collection)
        .doc(nationalVolunteerId.toString())
        .delete();
  }
}
