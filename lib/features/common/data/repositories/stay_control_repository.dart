import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/stay_control.dart';

abstract class StayControlRepository {
  Future<DataState<bool>> createStayControl(StayControlModel stayControl);

  Future<DataState<List<StayControlModel>>> getStayControls();

  Future<DataState<StayControlModel>> getStayControlById(
    int stayControlId,
  );

  Future<DataState<bool>> updateStayControl(StayControlModel stayControl);

  Future<DataState<bool>> deleteStayControl(StayControlModel stayControl);
}