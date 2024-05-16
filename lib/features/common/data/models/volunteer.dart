import 'package:flutter_application_1/core/resources/enums/gender.dart';

abstract class VolunteerModel {
  final int id;
  final String name;
  final DateTime birthDate;
  final int phoneNumber;
  final Gender gender;
  final String email;
  final String defaultPassword;

  VolunteerModel({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.phoneNumber,
    required this.gender,
    required this.defaultPassword,
    required this.email,
  });
}
