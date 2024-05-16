import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/allocation.dart';

class AllocationDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "allocations";

  Future create(AllocationModel allocation) async {
    await _instance
        .collection(_collection)
        .doc(allocation.id.toString())
        .set(allocation.toMap());
  }

  Future<AllocationModel?> read(int allocationId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(allocationId.toString())
        .get();
    return AllocationModel.fromMap(snapshot.data()!);
  }

  Future<List<AllocationModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => AllocationModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(AllocationModel allocation) async {
    await _instance
        .collection(_collection)
        .doc(allocation.id.toString())
        .update(allocation.toMap());
  }

  Future replace(AllocationModel allocation) async {
    await _instance
        .collection(_collection)
        .doc(allocation.id.toString())
        .set(allocation.toMap());
  }

  Future delete(int allocationId) async {
    await _instance
        .collection(_collection)
        .doc(allocationId.toString())
        .delete();
  }
}
