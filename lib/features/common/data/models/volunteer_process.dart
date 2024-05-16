import 'dart:convert';

class VolunteerProcessModel {
  final int id;
  final String activityArea;
  final bool criminalRecord;
  final bool medicalCertificate;
  final String academicLevel;

  VolunteerProcessModel({
    required this.id,
    required this.activityArea,
    required this.criminalRecord,
    required this.medicalCertificate,
    required this.academicLevel,
  });

  VolunteerProcessModel copyWith({
    int? id,
    String? activityArea,
    bool? criminalRecord,
    bool? medicalCertificate,
    String? academicLevel,
  }) {
    return VolunteerProcessModel(
      id: id ?? this.id,
      activityArea: activityArea ?? this.activityArea,
      criminalRecord: criminalRecord ?? this.criminalRecord,
      medicalCertificate: medicalCertificate ?? this.medicalCertificate,
      academicLevel: academicLevel ?? this.academicLevel,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'activityArea': activityArea});
    result.addAll({'criminalRecord': criminalRecord});
    result.addAll({'medicalCertificate': medicalCertificate});
    result.addAll({'academicLevel': academicLevel});
  
    return result;
  }

  factory VolunteerProcessModel.fromMap(Map<String, dynamic> map) {
    return VolunteerProcessModel(
      id: map['id']?.toInt() ?? 0,
      activityArea: map['activityArea'] ?? '',
      criminalRecord: map['criminalRecord'] ?? false,
      medicalCertificate: map['medicalCertificate'] ?? false,
      academicLevel: map['academicLevel'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VolunteerProcessModel.fromJson(String source) => VolunteerProcessModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VolunteerProcessModel(id: $id, activityArea: $activityArea, criminalRecord: $criminalRecord, medicalCertificate: $medicalCertificate, academicLevel: $academicLevel)';
  }
}
