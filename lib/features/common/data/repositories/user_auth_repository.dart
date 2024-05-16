import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/models/national_volunteer.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';

abstract class UserAuthRepository {
  
  // R E G I S T E R     M E T H O D S
  Future<DataState<InternationalVolunteerModel?>> signupUserIntVolunteer(InternationalVolunteerModel user, String password);
  Future<DataState<NationalVolunteerModel?>> signupUserNatVolunteer(NationalVolunteerModel user, String password);
  Future<DataState<CnvWorkerModel?>> signupUserCnvWorker(CnvWorkerModel user, String password);
  Future<DataState<PromoterEntityWorkerModel?>> signupUserPromEntWorker(PromoterEntityWorkerModel user, String password);
  
  // L O G I N     M E T H O D S
  Future<DataState<InternationalVolunteerModel>> signinUserIntVolunteer(String email, String password);
  Future<DataState<NationalVolunteerModel>> signinUserNatVolunteer(String email, String password);
  Future<DataState<CnvWorkerModel>> signinUserCnvWorker(String email, String password);
  Future<DataState<PromoterEntityWorkerModel>> signinUserPromEntWorker(String email, String password);
  
  // L O G O U T     M E T H O D S
  Future<DataState<bool>> logoutUser();
  
}