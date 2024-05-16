import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';

class PromoterEntityWorkerDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "promoter_entity_workers";

  Future create(PromoterEntityWorkerModel promoterEntityWorker) async {
    await _instance
        .collection(_collection)
        .doc(promoterEntityWorker.id.toString())
        .set(promoterEntityWorker.toMap());
  }

  Future<PromoterEntityWorkerModel?> read(int promoterEntityWorkerId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(promoterEntityWorkerId.toString())
        .get();
    return PromoterEntityWorkerModel.fromMap(snapshot.data()!);
  }
  
    Future<PromoterEntityWorkerModel?> readByEmail(String email) async {
    final snapshot = await _instance
        .collection(_collection)
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return PromoterEntityWorkerModel.fromMap(snapshot.docs.first.data());
    }
  }

  Future<List<PromoterEntityWorkerModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => PromoterEntityWorkerModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(PromoterEntityWorkerModel promoterEntityWorker) async {
    await _instance
        .collection(_collection)
        .doc(promoterEntityWorker.id.toString())
        .update(promoterEntityWorker.toMap());
  }

  Future replace(PromoterEntityWorkerModel promoterEntityWorker) async {
    await _instance
        .collection(_collection)
        .doc(promoterEntityWorker.id.toString())
        .set(promoterEntityWorker.toMap());
  }

  Future delete(int promoterEntityWorkerId) async {
    await _instance
        .collection(_collection)
        .doc(promoterEntityWorkerId.toString())
        .delete();
  }
}