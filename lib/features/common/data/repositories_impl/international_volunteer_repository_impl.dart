import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/repositories/international_volunteer_repository.dart';

class InternationalVolunteerRepositoryImpl
    extends InternationalVolunteerRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createInternationalVolunteer(
      InternationalVolunteerModel internationalVolunteer) async {
    try {
      await _database.internationalVolunteerDao.create(internationalVolunteer);

      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteInternationalVolunteer(
      InternationalVolunteerModel internationalVolunteer) async {
    try {
      await _database.internationalVolunteerDao
          .delete(internationalVolunteer.id);

      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<InternationalVolunteerModel>>>
      getInternationalVolunteer() async {
    try {
      List<InternationalVolunteerModel> list =
          await _database.internationalVolunteerDao.readAll();
      return DataSuccess(list);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<InternationalVolunteerModel>> getInternationalVolunteerById(
      int internationalVolunteerId) async {
    try {
      var res = await _database.internationalVolunteerDao
          .read(internationalVolunteerId);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateInternationalVolunteer(
      InternationalVolunteerModel internationalVolunteer) async {
    try {
      await _database.internationalVolunteerDao.create(internationalVolunteer);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
  
  @override
  Future<DataState<InternationalVolunteerModel>> getInternationalVolunteerByEmail(String email) async {
    try {
      InternationalVolunteerModel? res = await _database.internationalVolunteerDao.readByEmail(email);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
  
}
