import 'package:flutter_application_1/core/constants/general.dart';
import 'package:flutter_application_1/core/resources/enums/gender.dart';
import 'package:flutter_application_1/features/common/data/models/cnv_worker.dart';
import 'package:flutter_application_1/features/common/data/models/international_volunteer.dart';
import 'package:flutter_application_1/features/common/data/models/promoter_entity_worker.dart';

CnvWorkerModel mockCnvWorker = CnvWorkerModel(
  id: 12345678,
  name: "mario",
  email: "mario@mail.com",
  idNumber: "1234567",
  gender: Gender.Masculino,
  phoneNumber: 845566777,
  position: "Manager",
);

PromoterEntityWorkerModel mockPEWorkerModel = PromoterEntityWorkerModel(
  id: 35254324,
  name: "Ana",
  email: "ana@mail.com",
  idNumber: "86576576",
  gender: Gender.Femenino,
  phoneNumber: 823344555,
  position: "Staff",
);

InternationalVolunteerModel mockIntlVolunteer = InternationalVolunteerModel(
  passportNumber: "1234567890W",
  stayTime: 23,
  nationality: "Austríaca",
  id: 12345,
  name: "Diva",
  birthDate: DateTime.now(),
  phoneNumber: 823344555,
  gender: Gender.Femenino,
  email: "diva@mail.com",
  defaultPassword: kDefaultPassword
);
