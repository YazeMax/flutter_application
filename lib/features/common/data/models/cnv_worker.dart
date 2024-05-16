import 'dart:convert';

import 'package:flutter_application_1/core/resources/enums/gender.dart';

class CnvWorkerModel {
  final int id;
  final String name;
  final String idNumber;
  final String email;
  final Gender gender;
  final int phoneNumber;
  final String position;

  CnvWorkerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.idNumber,
    required this.gender,
    required this.phoneNumber,
    required this.position,
  });

  CnvWorkerModel copyWith({
    int? id,
    String? name,
    String? idNumber,
    String? email,
    Gender? gender,
    int? phoneNumber,
    String? position,
  }) {
    return CnvWorkerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      idNumber: idNumber ?? this.idNumber,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'idNumber': idNumber});
    result.addAll({'gender': gender.name});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'position': position});

    return result;
  }

  factory CnvWorkerModel.fromMap(Map<String, dynamic> map) {
    return CnvWorkerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      idNumber: map['idNumber'] ?? '',
      gender: Gender.values.firstWhere((g) => g.name == map['gender'].toString()),
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      position: map['position'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CnvWorkerModel.fromJson(String source) =>
      CnvWorkerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CnvWorkerModel(id: $id, name: $name, name: $email, idNumber: $idNumber, gender: $gender, phoneNumber: $phoneNumber, position: $position)';
  }
}
