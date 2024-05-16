import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/activity_report.dart';

abstract class ActivityReportRepository {
  Future<DataState<bool>> createActivityReport(ActivityReportModel activityReport);

  Future<DataState<List<ActivityReportModel>>> getActivityReport();

  Future<DataState<ActivityReportModel>> getActivityReportById(
    int activityReportId,
  );

  Future<DataState<bool>> updateActivityReport(ActivityReportModel activityReport);

  Future<DataState<bool>> deleteActivityReport(ActivityReportModel activityReport);
}
