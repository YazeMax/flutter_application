import 'dart:convert';

import 'package:flutter_application_1/core/resources/enums/gender.dart';

class PromoterEntityWorkerModel {
  final int id;
  final String name;
  final String email;
  final String idNumber;
  final Gender gender;
  final int phoneNumber;
  final String position;

  PromoterEntityWorkerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.idNumber,
    required this.gender,
    required this.phoneNumber,
    required this.position,
  });

  PromoterEntityWorkerModel copyWith({
    int? id,
    String? name,
    String? email,
    String? idNumber,
    Gender? gender,
    int? phoneNumber,
    String? position,
  }) {
    return PromoterEntityWorkerModel(
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

  factory PromoterEntityWorkerModel.fromMap(Map<String, dynamic> map) {
    return PromoterEntityWorkerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      idNumber: map['idNumber'] ?? '',
      gender: Gender.values.firstWhere((g) => g.name == map['gender']),
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      position: map['position'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PromoterEntityWorkerModel.fromJson(String source) => PromoterEntityWorkerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PromoterEntityWorkerModel(id: $id, name: $name, email: $email, idNumber: $idNumber, gender: $gender, phoneNumber: $phoneNumber, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PromoterEntityWorkerModel &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.idNumber == idNumber &&
      other.gender == gender &&
      other.phoneNumber == phoneNumber &&
      other.position == position;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      idNumber.hashCode ^
      gender.hashCode ^
      phoneNumber.hashCode ^
      position.hashCode;
  }
}
