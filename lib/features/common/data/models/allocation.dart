import 'dart:convert';

class AllocationModel {
  final int id;
  final int numOfVolunteers;
  final String trainingArea;
  final String operationsSector;
  final DateTime startDate;
  final DateTime finalDate;

  AllocationModel({
    required this.id,
    required this.numOfVolunteers,
    required this.trainingArea,
    required this.operationsSector,
    required this.startDate,
    required this.finalDate,
  });

  AllocationModel copyWith({
    int? id,
    int? numOfVolunteers,
    String? trainingArea,
    String? operationsSector,
    DateTime? startDate,
    DateTime? finalDate,
  }) {
    return AllocationModel(
      id: id ?? this.id,
      numOfVolunteers: numOfVolunteers ?? this.numOfVolunteers,
      trainingArea: trainingArea ?? this.trainingArea,
      operationsSector: operationsSector ?? this.operationsSector,
      startDate: startDate ?? this.startDate,
      finalDate: finalDate ?? this.finalDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'numOfVolunteers': numOfVolunteers});
    result.addAll({'trainingArea': trainingArea});
    result.addAll({'operationsSector': operationsSector});
    result.addAll({'startDate': startDate.toIso8601String()});
    result.addAll({'finalDate': finalDate.toIso8601String()});

    return result;
  }

  factory AllocationModel.fromMap(Map<String, dynamic> map) {
    return AllocationModel(
      id: map['id']?.toInt() ?? 0,
      numOfVolunteers: map['numOfVolunteers']?.toInt() ?? 0,
      trainingArea: map['trainingArea'] ?? '',
      operationsSector: map['operationsSector'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      finalDate: DateTime.parse(map['finalDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllocationModel.fromJson(String source) =>
      AllocationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AllocationModel(id: $id, numOfVolunteers: $numOfVolunteers, trainingArea: $trainingArea, operationsSector: $operationsSector, startDate: $startDate, finalDate: $finalDate)';
  }
}
