import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';

abstract class PromoterEntityWorkerRepository {
    Future<DataState<bool>> createPromoterEntityWorker(PromoterEntityWorkerModel promoterEntityWorker);

  Future<DataState<List<PromoterEntityWorkerModel>>> getPromoterEntityWorker();

  Future<DataState<PromoterEntityWorkerModel>> getPromoterEntityWorkerById(
    int promoterEntityWorkerId,
  );

  Future<DataState<PromoterEntityWorkerModel>> getPromoterEntityWorkerByEmail(
    String email,
  );

  Future<DataState<bool>> updatePromoterEntityWorker(PromoterEntityWorkerModel promoterEntityWorker);

  Future<DataState<bool>> deletePromoterEntityWorker(PromoterEntityWorkerModel promoterEntityWorker);
}