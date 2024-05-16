import 'dart:convert';

class StayControlModel {
  final int id;
  final DateTime startDate;
  final DateTime finalDate;
  final String state;

  StayControlModel({
    required this.id,
    required this.startDate,
    required this.finalDate,
    required this.state,
  });

  StayControlModel copyWith({
    int? id,
    DateTime? startDate,
    DateTime? finalDate,
    String? state,
  }) {
    return StayControlModel(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      finalDate: finalDate ?? this.finalDate,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'startDate': startDate.toIso8601String()});
    result.addAll({'finalDate': finalDate.toIso8601String()});
    result.addAll({'state': state});
  
    return result;
  }

  factory StayControlModel.fromMap(Map<String, dynamic> map) {
    return StayControlModel(
      id: map['id']?.toInt() ?? 0,
      startDate: DateTime.parse(map['startDate']),
      finalDate: DateTime.parse(map['finalDate']),
      state: map['state'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StayControlModel.fromJson(String source) => StayControlModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StayControlModel(id: $id, startDate: $startDate, finalDate: $finalDate, state: $state)';
  }
}
