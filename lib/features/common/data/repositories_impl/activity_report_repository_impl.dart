import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/activity_report.dart';
import 'package:flutter_application_1/features/common/data/repositories/activity_report_repository.dart';

class ActivityReportRepositoryImpl extends ActivityReportRepository {
  final FirestoreDatabase _database = FirestoreDatabase();
  @override
  Future<DataState<bool>> createActivityReport(
      ActivityReportModel activityReport) async {
    try {
      await _database.activityReportDao.create(activityReport);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteActivityReport(ActivityReportModel activityReport) async {
    try {
      await _database.activityReportDao.delete(activityReport.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<ActivityReportModel>>> getActivityReport() async {
    try {
      var list = await _database.activityReportDao.readAll();
      return DataSuccess(list);
    } catch (e) {
      return DataFailure(RemoteError(
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<DataState<ActivityReportModel>> getActivityReportById(
    int activityReportId,
  ) async {
    try {
      var value = await _database.activityReportDao.read(activityReportId);
      return DataSuccess(value!);
    } catch (e) {
      return DataFailure(RemoteError(
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<DataState<bool>> updateActivityReport(ActivityReportModel activityReport) async {
    try {
      await _database.activityReportDao.update(activityReport);
      
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
