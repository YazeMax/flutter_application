import 'dart:convert';

import 'package:flutter_application_1/features/common/data/models/volunteer.dart';

import 'package:flutter_application_1/core/resources/enums/gender.dart';

class NationalVolunteerModel extends VolunteerModel {
  final String idNumber;
  final String province;
  final String district;
  final int householdNumber;

  NationalVolunteerModel({
    required this.idNumber,
    required this.province,
    required this.district,
    required this.householdNumber,
    required super.id,
    required super.name,
    required super.birthDate,
    required super.phoneNumber,
    required super.defaultPassword,
    required super.gender,
    required super.email,
  });

  NationalVolunteerModel copyWith({
    String? idNumber,
    String? province,
    String? district,
    int? householdNumber,
    int? id,
    String? name,
    DateTime? birthDate,
    int? phoneNumber,
    Gender? gender,
    String? email,
    String? defaultPassword,
  }) {
    return NationalVolunteerModel(
      idNumber: idNumber ?? this.idNumber,
      province: province ?? this.province,
      district: district ?? this.district,
      householdNumber: householdNumber ?? this.householdNumber,
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      defaultPassword: defaultPassword ?? this.defaultPassword,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idNumber': idNumber});
    result.addAll({'province': province});
    result.addAll({'district': district});
    result.addAll({'householdNumber': householdNumber});
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'birthDate': birthDate.toIso8601String()});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender.name});
    result.addAll({'email': email});
    result.addAll({'defaultPassword': defaultPassword});

    return result;
  }

  factory NationalVolunteerModel.fromMap(Map<String, dynamic> map) {
    return NationalVolunteerModel(
      idNumber: map['idNumber'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      householdNumber: map['householdNumber']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      birthDate: DateTime.parse(map['birthDate']),
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      gender: Gender.values.firstWhere((g) => g.name == map['gender']),
      email: map['email'] ?? '',
      defaultPassword: map['defaultPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NationalVolunteerModel.fromJson(String source) =>
      NationalVolunteerModel.fromMap(json.decode(source));
}
