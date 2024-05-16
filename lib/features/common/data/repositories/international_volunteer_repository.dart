import 'package:flutter_application_1/core/resources/data_state.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';

abstract class InternationalVolunteerRepository {
  Future<DataState<bool>> createInternationalVolunteer(InternationalVolunteerModel internationalVolunteer);

  Future<DataState<List<InternationalVolunteerModel>>> getInternationalVolunteer();

  Future<DataState<InternationalVolunteerModel>> getInternationalVolunteerById(
    int internationalVolunteerId,
  );

  Future<DataState<InternationalVolunteerModel>> getInternationalVolunteerByEmail(
    String email,
  );

  Future<DataState<bool>> updateInternationalVolunteer(InternationalVolunteerModel internationalVolunteer);

  Future<DataState<bool>> deleteInternationalVolunteer(InternationalVolunteerModel internationalVolunteer);
}
