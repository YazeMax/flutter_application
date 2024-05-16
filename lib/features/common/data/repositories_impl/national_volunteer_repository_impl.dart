import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/national_volunteer.dart';
import 'package:flutter_application_1/features/common/data/repositories/national_volunteer_repository.dart';

class NationalVolunteerRepositoryImpl extends NationalVolunteerRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createNationalVolunteer(
      NationalVolunteerModel nationalVolunteer) async {
    try {
      await _database.nationalVolunteerDao.create(nationalVolunteer);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteNationalVolunteer(
      NationalVolunteerModel nationalVolunteer) async {
    try {
      await _database.nationalVolunteerDao.delete(nationalVolunteer.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<NationalVolunteerModel>>> getNationalVolunteer() async {
    try {
      List<NationalVolunteerModel> list =
          await _database.nationalVolunteerDao.readAll();
      return DataSuccess(list);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<NationalVolunteerModel>> getNationalVolunteerById(
      int nationalVolunteerId) async {
    try {
      NationalVolunteerModel? res =
          await _database.nationalVolunteerDao.read(nationalVolunteerId);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateNationalVolunteer(
      NationalVolunteerModel nationalVolunteer) async {
    try {
      await _database.nationalVolunteerDao.update(nationalVolunteer);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
  
  @override
  Future<DataState<NationalVolunteerModel>> getNationalVolunteerByEmail(String email) async {
    try {
      NationalVolunteerModel? res = await _database.nationalVolunteerDao.readByEmail(email);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
