import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/volunteer_process.dart';
import 'package:flutter_application_1/features/common/data/repositories/volunteer_process_repository.dart';

class VolunteerProcessRepositoryImpl extends VolunteerProcessRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createVolunteerProcess(
      VolunteerProcessModel volunteerProcess) async {
    try {
      await _database.volunteerProcessDao.create(volunteerProcess);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteVolunteerProcess(
      VolunteerProcessModel volunteerProcess) async {
    try {
      await _database.volunteerProcessDao.delete(volunteerProcess.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<VolunteerProcessModel>>> getVolunteerProcess() async {
    try {
      List<VolunteerProcessModel> res =
          await _database.volunteerProcessDao.readAll();
      return DataSuccess(res);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<VolunteerProcessModel>> getVolunteerProcessById(
      int volunteerProcessId) async {
    try {
      VolunteerProcessModel? res =
          await _database.volunteerProcessDao.read(volunteerProcessId);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateVolunteerProcess(
      VolunteerProcessModel volunteerProcess) async {
    try {
      await _database.volunteerProcessDao.update(volunteerProcess);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
