import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/national_volunteer.dart';

abstract class NationalVolunteerRepository {
  Future<DataState<bool>> createNationalVolunteer(NationalVolunteerModel nationalVolunteer);

  Future<DataState<List<NationalVolunteerModel>>> getNationalVolunteer();

  Future<DataState<NationalVolunteerModel>> getNationalVolunteerById(
    int nationalVolunteerId,
  );

  Future<DataState<NationalVolunteerModel>> getNationalVolunteerByEmail(
    String email,
  );

  Future<DataState<bool>> updateNationalVolunteer(NationalVolunteerModel nationalVolunteer);

  Future<DataState<bool>> deleteNationalVolunteer(NationalVolunteerModel nationalVolunteer);
}