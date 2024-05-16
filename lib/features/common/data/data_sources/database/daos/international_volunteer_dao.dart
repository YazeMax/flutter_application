import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';

class InternationalVolunteerDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "international_volunteers";

  Future create(InternationalVolunteerModel internationalVolunteer) async {
    await _instance
        .collection(_collection)
        .doc(internationalVolunteer.id.toString())
        .set(internationalVolunteer.toMap());
  }

  Future<InternationalVolunteerModel?> read(
    int internationalVolunteerId,
  ) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .doc(internationalVolunteerId.toString())
        .get();
    return InternationalVolunteerModel.fromMap(snapshot.data()!);
  }
    Future<InternationalVolunteerModel?> readByEmail(String email) async {
    final snapshot = await _instance
        .collection(_collection)
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return InternationalVolunteerModel.fromMap(snapshot.docs.first.data());
    }
  }

  Future<List<InternationalVolunteerModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => InternationalVolunteerModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(InternationalVolunteerModel internationalVolunteer) async {
    await _instance
        .collection(_collection)
        .doc(internationalVolunteer.id.toString())
        .update(internationalVolunteer.toMap());
  }

  Future replace(InternationalVolunteerModel internationalVolunteer) async {
    await _instance
        .collection(_collection)
        .doc(internationalVolunteer.id.toString())
        .set(internationalVolunteer.toMap());
  }

  Future delete(int internationalVolunteerId) async {
    await _instance
        .collection(_collection)
        .doc(internationalVolunteerId.toString())
        .delete();
  }
}
