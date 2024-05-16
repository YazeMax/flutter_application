import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';
import 'package:flutter_application_1/features/common/data/repositories/promoter_entity_worker_repository.dart';

class PromoterEntityWorkerRepositoryImpl
    extends PromoterEntityWorkerRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createPromoterEntityWorker(
      PromoterEntityWorkerModel promoterEntityWorker) async {
    try {
      await _database.promoterEntityWorkerDao.create(promoterEntityWorker);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deletePromoterEntityWorker(
      PromoterEntityWorkerModel promoterEntityWorker) async {
    try {
      await _database.promoterEntityWorkerDao.delete(promoterEntityWorker.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<PromoterEntityWorkerModel>>>
      getPromoterEntityWorker() async {
    try {
      List<PromoterEntityWorkerModel> list =
          await _database.promoterEntityWorkerDao.readAll();
      return DataSuccess(list);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<PromoterEntityWorkerModel>> getPromoterEntityWorkerById(
      int promoterEntityWorkerId) async {
    try {
      PromoterEntityWorkerModel? res =
          await _database.promoterEntityWorkerDao.read(promoterEntityWorkerId);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updatePromoterEntityWorker(
      PromoterEntityWorkerModel promoterEntityWorker) async {
    try {
      await _database.promoterEntityWorkerDao.update(promoterEntityWorker);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
  
  @override
  Future<DataState<PromoterEntityWorkerModel>> getPromoterEntityWorkerByEmail(String email) async {
    try {
      PromoterEntityWorkerModel? res = await _database.promoterEntityWorkerDao.readByEmail(email);
      return DataSuccess(res!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
