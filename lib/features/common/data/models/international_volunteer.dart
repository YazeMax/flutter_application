import 'dart:convert';

import 'package:flutter_application_1/features/common/data/models/volunteer.dart';

import 'package:flutter_application_1/core/resources/enums/gender.dart';

class InternationalVolunteerModel extends VolunteerModel {
  final String passportNumber;
  final int stayTime;
  final String nationality;

  InternationalVolunteerModel({
    required this.passportNumber,
    required this.stayTime,
    required this.nationality,
    required super.id,
    required super.name,
    required super.birthDate,
    required super.phoneNumber,
    required super.gender,
    required super.email,
    required super.defaultPassword,
  });

  VolunteerModel copyWith({
    int? id,
    String? name,
    DateTime? birthDate,
    int? phoneNumber,
    Gender? gender,
    String? email,
    String? passportNumber,
    int? stayTime,
    String? nationality,
    String? defaultPassword,
  }) {
    return InternationalVolunteerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      passportNumber: passportNumber ?? this.passportNumber,
      stayTime: stayTime ?? this.stayTime,
      nationality: nationality ?? this.nationality,
      defaultPassword: defaultPassword ?? this.defaultPassword,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'birthDate': birthDate.toIso8601String()});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender.name});
    result.addAll({'email': email});
    result.addAll({'passportNumber': passportNumber});
    result.addAll({'stayTime': stayTime});
    result.addAll({'nationality': nationality});
    result.addAll({'defaultPassword': defaultPassword});

    return result;
  }

  factory InternationalVolunteerModel.fromMap(Map<String, dynamic> map) {
    return InternationalVolunteerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      birthDate: DateTime.parse(map['birthDate']),
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      gender: Gender.values.firstWhere((g) => g.name == map['gender']),
      email: map['email'] ?? '',
      passportNumber: map['passportNumber'] ?? '',
      stayTime: map['stayTime']?.toInt() ?? 0,
      nationality: map['nationality'] ?? '',
      defaultPassword: map['defaultPassword'] ?? '',
    );
  }

  factory InternationalVolunteerModel.fromJson(String source) => InternationalVolunteerModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

}
