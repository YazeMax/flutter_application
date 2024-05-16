import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_activity.dart';
import 'package:flutter_application_1/features/common/data/repositories/volunteer_activity_repository.dart';

class VolunteerActivityRepositoryImpl extends VolunteerActivityRepository {
  final FirestoreDatabase _database = FirestoreDatabase();
  @override
  Future<DataState<bool>> createVolunteerActivity(
      VolunteerActivityModel volunteerActivity) async {
    try {
      await _database.volunteerActivityDao.create(volunteerActivity);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteVolunteerActivity(
      VolunteerActivityModel volunteerActivity) async {
    try {
      await _database.volunteerActivityDao.delete(volunteerActivity.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<VolunteerActivityModel>>> getVolunteerActivity() async {
    try {
      List<VolunteerActivityModel> res =
          await _database.volunteerActivityDao.readAll();
      return DataSuccess(res);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<VolunteerActivityModel>> getVolunteerActivityById(
      int volunteerActivityId) async {
    try {
      VolunteerActivityModel? res =
          await _database.volunteerActivityDao.read(volunteerActivityId);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateVolunteerActivity(
      VolunteerActivityModel volunteerActivity) async {
    try {
      await _database.volunteerActivityDao.update(volunteerActivity);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
