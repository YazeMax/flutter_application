import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';

abstract class CnvWorkerRepository {
  Future<DataState<bool>> createCnvWorker(CnvWorkerModel cnvWorker);

  Future<DataState<List<CnvWorkerModel>>> getCnvWorker();

  Future<DataState<CnvWorkerModel>> getCnvWorkerById(
    int cnvWorkerId,
  );

  Future<DataState<CnvWorkerModel>> getCnvWorkerByEmail(
    String email,
  );

  Future<DataState<bool>> updateCnvWorker(CnvWorkerModel cnvWorker);

  Future<DataState<bool>> deleteCnvWorker(CnvWorkerModel cnvWorker);
}
