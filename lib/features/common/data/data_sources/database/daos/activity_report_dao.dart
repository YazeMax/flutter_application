import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/common/data/models/activity_report.dart';

class ActivityReportDao {
  static final _instance = FirebaseFirestore.instance;
  static const String _collection = "activity_reports";

  Future create(ActivityReportModel activityReport) async {
    await _instance
        .collection(_collection)
        .doc(activityReport.id.toString())
        .set(activityReport.toMap());
  }

  Future<ActivityReportModel?> read(int activityReportId) async {
    final snapshot = await _instance
        .collection(_collection)
        .doc(activityReportId.toString())
        .get();
    return ActivityReportModel.fromMap(snapshot.data()!);
  }

  Future<List<ActivityReportModel>> readAll() async {
    final snapshot = await _instance.collection(_collection).get();
    var list = snapshot.docs
        .map((doc) => ActivityReportModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future update(ActivityReportModel activityReport) async {
    await _instance
        .collection(_collection)
        .doc(activityReport.id.toString())
        .update(activityReport.toMap());
  }

  Future replace(ActivityReportModel activityReport) async {
    await _instance
        .collection(_collection)
        .doc(activityReport.id.toString())
        .set(activityReport.toMap());
  }

  Future delete(int activityReportId) async {
    await _instance
        .collection(_collection)
        .doc(activityReportId.toString())
        .delete();
  }
}
