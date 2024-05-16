import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_activity.dart';

abstract class VolunteerActivityRepository {
  Future<DataState<bool>> createVolunteerActivity(VolunteerActivityModel volunteerActivity);

  Future<DataState<List<VolunteerActivityModel>>> getVolunteerActivity();

  Future<DataState<VolunteerActivityModel>> getVolunteerActivityById(
    int volunteerActivityId,
  );

  Future<DataState<bool>> updateVolunteerActivity(VolunteerActivityModel volunteerActivity);

  Future<DataState<bool>> deleteVolunteerActivity(VolunteerActivityModel volunteerActivity);
}