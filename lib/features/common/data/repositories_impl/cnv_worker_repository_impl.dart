import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';
import 'package:flutter_application_1/features/common/data/repositories/cnv_worker_repository.dart';

class CnvWorkerRepositoryImpl extends CnvWorkerRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createCnvWorker(CnvWorkerModel cnvWorker) async {
    try {
      await await _database.cnvWorkerDao.create(cnvWorker);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteCnvWorker(CnvWorkerModel cnvWorker) async {
    try {
      await _database.cnvWorkerDao.delete(cnvWorker.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<CnvWorkerModel>>> getCnvWorker() async {
    try {
      List<CnvWorkerModel> list = await _database.cnvWorkerDao.readAll();
      return DataSuccess(list);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<CnvWorkerModel>> getCnvWorkerById(int cnvWorkerId) async {
    try {
      var cnvWorker = await _database.cnvWorkerDao.read(cnvWorkerId);
      return DataSuccess(cnvWorker!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateCnvWorker(CnvWorkerModel cnvWorker) async {
    try {
      await _database.cnvWorkerDao.update(cnvWorker);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<CnvWorkerModel>> getCnvWorkerByEmail(String email) async {
    try {
      CnvWorkerModel? res = await _database.cnvWorkerDao.readByEmail(email);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
