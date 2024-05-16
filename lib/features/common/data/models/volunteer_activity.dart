import 'dart:convert';

class VolunteerActivityModel {
  final int id;
  final String type;
  final String place;
  final DateTime date;
  final int durationInDays;
  
  VolunteerActivityModel({
    required this.id,
    required this.type,
    required this.place,
    required this.date,
    required this.durationInDays,
  });

  VolunteerActivityModel copyWith({
    int? id,
    String? type,
    String? place,
    DateTime? date,
    int? durationInDays,
  }) {
    return VolunteerActivityModel(
      id: id ?? this.id,
      type: type ?? this.type,
      place: place ?? this.place,
      date: date ?? this.date,
      durationInDays: durationInDays ?? this.durationInDays,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'type': type});
    result.addAll({'place': place});
    result.addAll({'date': date.toIso8601String()});
    result.addAll({'durationInDays': durationInDays});

    return result;
  }

  factory VolunteerActivityModel.fromMap(Map<String, dynamic> map) {
    return VolunteerActivityModel(
      id: map['id']?.toInt() ?? 0,
      type: map['type'] ?? '',
      place: map['place'] ?? '',
      date: DateTime.parse(map['date']),
      durationInDays: map['durationInDays']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VolunteerActivityModel.fromJson(String source) =>
      VolunteerActivityModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VolunteerActivityModel(id: $id, type: $type, place: $place, date: $date, durationInDays: $durationInDays)';
  }
}
