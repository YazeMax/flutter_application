import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';

class CnvWorkerDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "cnv_workers";

  Future create(CnvWorkerModel cnvWorker) async {
    await _instance
        .collection(_collection)
        .doc(cnvWorker.id.toString())
        .set(cnvWorker.toMap());
  }

  Future<CnvWorkerModel?> read(int cnvWorkerId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(cnvWorkerId.toString())
        .get();
    return CnvWorkerModel.fromMap(snapshot.data()!);
  }

  Future<CnvWorkerModel?> readByEmail(String email) async {
    final snapshot = await _instance
        .collection(_collection)
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return CnvWorkerModel.fromMap(snapshot.docs.first.data());
    }
  }

  Future<List<CnvWorkerModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list =
        snapshot.docs.map((doc) => CnvWorkerModel.fromMap(doc.data())).toList();
    return list;
  }

  Future update(CnvWorkerModel cnvWorker) async {
    await _instance
        .collection(_collection)
        .doc(cnvWorker.id.toString())
        .update(cnvWorker.toMap());
  }

  Future replace(CnvWorkerModel cnvWorker) async {
    await _instance
        .collection(_collection)
        .doc(cnvWorker.id.toString())
        .set(cnvWorker.toMap());
  }

  Future delete(int cnvWorkerId) async {
    await _instance
        .collection(_collection)
        .doc(cnvWorkerId.toString())
        .delete();
  }
}
