import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/firestore_database.dart';
import 'package:flutter_application_1/features/common/data/models/allocation.dart';
import 'package:flutter_application_1/features/common/data/repositories/allocation_repository.dart';

class AllocationRepositoryImpl extends AllocationRepository {
  final FirestoreDatabase _database = FirestoreDatabase();

  @override
  Future<DataState<bool>> createAllocation(AllocationModel allocation) async {
    try {
      await _database.allocationDao.create(allocation);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> deleteAllocation(AllocationModel allocation) async {
    try {
      await _database.allocationDao.delete(allocation.id);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<List<AllocationModel>>> getAllocation() async {
    try {
      List<AllocationModel> list = await _database.allocationDao.readAll();
      return DataSuccess(list);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<AllocationModel>> getAllocationById(int allocationId) async {
    try {
      var allocation = await _database.allocationDao.read(allocationId);
      return DataSuccess(allocation!);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }

  @override
  Future<DataState<bool>> updateAllocation(AllocationModel allocation) async {
    try {
      await _database.allocationDao.update(allocation);
      return DataSuccess(true);
    } catch (e) {
      return DataFailure(RemoteError(code: null, message: e.toString()));
    }
  }
}
