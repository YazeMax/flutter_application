import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/allocation.dart';

abstract class AllocationRepository {
  Future<DataState<bool>> createAllocation(AllocationModel allocation);

  Future<DataState<List<AllocationModel>>> getAllocation();

  Future<DataState<AllocationModel>> getAllocationById(
    int allocationId,
  );

  Future<DataState<bool>> updateAllocation(AllocationModel allocation);

  Future<DataState<bool>> deleteAllocation(AllocationModel allocation);
}
