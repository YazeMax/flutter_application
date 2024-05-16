import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_process.dart';

abstract class VolunteerProcessRepository {
  Future<DataState<bool>> createVolunteerProcess(VolunteerProcessModel volunteerProcess);

  Future<DataState<List<VolunteerProcessModel>>> getVolunteerProcess();

  Future<DataState<VolunteerProcessModel>> getVolunteerProcessById(
    int volunteerProcessId,
  );

  Future<DataState<bool>> updateVolunteerProcess(VolunteerProcessModel volunteerProcess);

  Future<DataState<bool>> deleteVolunteerProcess(VolunteerProcessModel volunteerProcess);
}