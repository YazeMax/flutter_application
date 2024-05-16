import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/core/resources/error.dart';
import 'package:flutter_application_1/features/common/data/data_sources/authentication/firebase_auth_service.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/models/national_volunteer.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';
import 'package:flutter_application_1/features/common/data/repositories/user_auth_repository.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/cnv_worker_repository_impl.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/international_volunteer_repository_impl.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/national_volunteer_repository_impl.dart';
import 'package:flutter_application_1/features/common/data/repositories_impl/promoter_entity_worker_repository_impl.dart';

class UserAuthRepositoryImpl extends UserAuthRepository {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final InternationalVolunteerRepositoryImpl
      _internationalVolunteerRepositoryImpl =
      InternationalVolunteerRepositoryImpl();
  final NationalVolunteerRepositoryImpl _nationalVolunteerRepositoryImpl =
      NationalVolunteerRepositoryImpl();
  final CnvWorkerRepositoryImpl _cnvWorkerRepositoryImpl =
      CnvWorkerRepositoryImpl();
  final PromoterEntityWorkerRepositoryImpl _entityWorkerRepositoryImpl =
      PromoterEntityWorkerRepositoryImpl();

  @override
  Future<DataState<bool>> logoutUser() async {
    DataState<bool> res = await _auth.logout();
    if (res is DataSuccess) {
      return DataSuccess(true);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<CnvWorkerModel>> signinUserCnvWorker(
    String email,
    String password,
  ) async {
    DataState<bool> res = await _auth.login(email, password);
    if (res is DataSuccess) {
      DataState<CnvWorkerModel> userRes = await _cnvWorkerRepositoryImpl.getCnvWorkerByEmail(email);
      if (userRes is DataSuccess) {
        return DataSuccess(userRes.data!);
      } else {
        return DataFailure(userRes.error!);
      }
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<InternationalVolunteerModel>> signinUserIntVolunteer(
    String email,
    String password,
  ) async {
    DataState<bool> res = await _auth.login(email, password);
    if (res is DataSuccess) {
      var user = await _internationalVolunteerRepositoryImpl
          .getInternationalVolunteerByEmail(email);
      return DataSuccess(user.data!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<NationalVolunteerModel>> signinUserNatVolunteer(
    String email,
    String password,
  ) async {
    DataState<bool> res = await _auth.login(email, password);
    if (res is DataSuccess) {
      var user = await _nationalVolunteerRepositoryImpl
          .getNationalVolunteerByEmail(email);
      return DataSuccess(user.data!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<PromoterEntityWorkerModel>> signinUserPromEntWorker(
    String email,
    String password,
  ) async {
    DataState<bool> res = await _auth.createUser(email, password);
    if (res is DataSuccess) {
      var user = await _entityWorkerRepositoryImpl
          .getPromoterEntityWorkerByEmail(email);
      return DataSuccess(user.data!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<CnvWorkerModel>> signupUserCnvWorker(
    CnvWorkerModel user,
    String password,
  ) async {
    DataState<bool> res = await _auth.createUser(user.email, password);
    if (res is DataSuccess) {
      var userRes = await _cnvWorkerRepositoryImpl.createCnvWorker(user);
      if (userRes is DataSuccess) {
        return DataSuccess(user);
      }
      return DataFailure(userRes.error!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<InternationalVolunteerModel>> signupUserIntVolunteer(
    InternationalVolunteerModel user,
    String password,
  ) async {
    DataState<bool> res = await _auth.createUser(user.email, password);
    if (res is DataSuccess) {
      var userRes = await _internationalVolunteerRepositoryImpl
          .createInternationalVolunteer(user);
      if (userRes is DataSuccess) {
        return DataSuccess(user);
      }
      return DataFailure(userRes.error!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<NationalVolunteerModel>> signupUserNatVolunteer(
    NationalVolunteerModel user,
    String password,
  ) async {
    DataState<bool> res = await _auth.createUser(user.email, password);
    if (res is DataSuccess) {
      var userRes =
          await _nationalVolunteerRepositoryImpl.createNationalVolunteer(user);
      if (userRes is DataSuccess) {
        return DataSuccess(user);
      }
      return DataFailure(userRes.error!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }

  @override
  Future<DataState<PromoterEntityWorkerModel>> signupUserPromEntWorker(
    PromoterEntityWorkerModel user,
    String password,
  ) async {
    DataState<bool> res = await _auth.createUser(user.email, password);
    if (res is DataSuccess) {
      var userRes =
          await _entityWorkerRepositoryImpl.createPromoterEntityWorker(user);
      if (userRes is DataSuccess) {
        return DataSuccess(user);
      }
      return DataFailure(userRes.error!);
    }
    return DataFailure(RemoteError(
      code: res.error!.code,
      message: res.error!.message,
    ));
  }
}
