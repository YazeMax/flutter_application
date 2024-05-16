import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/stay_control.dart';
import 'package:flutter_application_1/features/common/data/repositories/stay_control_repository.dart';

class StayControlRepositoryImpl extends StayControlRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createStayControl(
      StayControlModel stayControl) async {
    try {
      await _database.stayControlDao.create(stayControl);

      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteStayControl(
      StayControlModel stayControl) async {
    try {
      await _database.stayControlDao.delete(stayControl.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<StayControlModel>> getStayControlById(
    int stayControlId,
  ) async {
    try {
      StayControlModel? res =
          await _database.stayControlDao.read(stayControlId);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<StayControlModel>>> getStayControls() async {
    try {
      List<StayControlModel> res = await _database.stayControlDao.readAll();
      return DataSuccess(res);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateStayControl(
      StayControlModel stayControl) async {
    try {
      await _database.stayControlDao.update(stayControl);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
