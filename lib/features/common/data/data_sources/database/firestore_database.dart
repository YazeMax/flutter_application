import 'package:flutter_application_1/features/common/data/data_sources/database/daos/activity_report_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/allocation_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/cnv_worker_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/international_volunteer_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/national_volunteer_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/promoter_entity_worker_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/stay_control_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/volunteer_activity_dao.dart';
import 'package:flutter_application_1/features/common/data/data_sources/database/daos/volunteer_process_dao.dart';

class FirestoreDatabase {
  final ActivityReportDao _activityReportDao = ActivityReportDao();
  final AllocationDao _allocationDao = AllocationDao();
  final CnvWorkerDao _cnvWorkerDao = CnvWorkerDao();
  final InternationalVolunteerDao _internationalVolunteerDao = InternationalVolunteerDao();
  final NationalVolunteerDao _nationalVolunteerDao = NationalVolunteerDao();
  final StayControlDao _stayControlDao = StayControlDao();
  final VolunteerActivityDao _volunteerActivityDao = VolunteerActivityDao();
  final VolunteerProcessDao _volunteerProcessDao = VolunteerProcessDao();
  final PromoterEntityWorkerDao _promoterEntityWorkerDao = PromoterEntityWorkerDao();

  ActivityReportDao get activityReportDao => _activityReportDao;
  AllocationDao get allocationDao => _allocationDao;
  CnvWorkerDao get cnvWorkerDao => _cnvWorkerDao;
  InternationalVolunteerDao get internationalVolunteerDao => _internationalVolunteerDao;
  NationalVolunteerDao get nationalVolunteerDao => _nationalVolunteerDao;
  StayControlDao get stayControlDao => _stayControlDao;
  VolunteerActivityDao get volunteerActivityDao => _volunteerActivityDao;
  VolunteerProcessDao get volunteerProcessDao => _volunteerProcessDao;
  PromoterEntityWorkerDao get promoterEntityWorkerDao => _promoterEntityWorkerDao;
}
