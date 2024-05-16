import 'dart:convert';

class ActivityReportModel {
  final int id;
  final String type;
  final String place;
  final DateTime date;
  final int durationInDays;
  final int numOfParticipants;
  final DateTime startDate;
  final DateTime finalDate;
  final String promotingEntityName;
  
  ActivityReportModel({
    required this.id,
    required this.type,
    required this.place,
    required this.date,
    required this.durationInDays,
    required this.numOfParticipants,
    required this.startDate,
    required this.finalDate,
    required this.promotingEntityName,
  });

  ActivityReportModel copyWith({
    int? id,
    String? type,
    String? place,
    DateTime? date,
    int? durationInDays,
    int? numOfParticipants,
    DateTime? startDate,
    DateTime? finalDate,
    String? promotingEntityName,
  }) {
    return ActivityReportModel(
      id: id ?? this.id,
      type: type ?? this.type,
      place: place ?? this.place,
      date: date ?? this.date,
      durationInDays: durationInDays ?? this.durationInDays,
      numOfParticipants: numOfParticipants ?? this.numOfParticipants,
      startDate: startDate ?? this.startDate,
      finalDate: finalDate ?? this.finalDate,
      promotingEntityName: promotingEntityName ?? this.promotingEntityName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'type': type});
    result.addAll({'place': place});
    result.addAll({'date': date.toIso8601String()});
    result.addAll({'durationInDays': durationInDays});
    result.addAll({'numOfParticipants': numOfParticipants});
    result.addAll({'startDate': startDate.toIso8601String()});
    result.addAll({'finalDate': finalDate.toIso8601String()});
    result.addAll({'promotingEntityName': promotingEntityName});
  
    return result;
  }

  factory ActivityReportModel.fromMap(Map<String, dynamic> map) {
    return ActivityReportModel(
      id: map['id']?.toInt() ?? 0,
      type: map['type'] ?? '',
      place: map['place'] ?? '',
      date: DateTime.parse(map['date']),
      durationInDays: map['durationInDays']?.toInt() ?? 0,
      numOfParticipants: map['numOfParticipants']?.toInt() ?? 0,
      startDate: DateTime.parse(map['startDate']),
      finalDate: DateTime.parse(map['finalDate']),
      promotingEntityName: map['promotingEntityName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityReportModel.fromJson(String source) => ActivityReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ActivityReportModel(id: $id, type: $type, place: $place, date: $date, durationInDays: $numOfParticipants, durationInDays: $numOfParticipants, startDate: $startDate, finalDate: $finalDate, promotingEntityName: $promotingEntityName)';
  }
}
