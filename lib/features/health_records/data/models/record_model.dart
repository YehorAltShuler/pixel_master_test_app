import 'package:pixel_master_test_app/features/health_records/domain/entities/health_record.dart';

class HealthRecordModel extends HealthRecord {
  HealthRecordModel({
    required super.id,
    required super.userId,
    required super.systolic,
    required super.diastolic,
    required super.pulse,
    required super.date,
    required super.time,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'systolic': systolic,
      'diastolic': diastolic,
      'pulse': pulse,
      'date': date,
      'time': time,
    };
  }

  factory HealthRecordModel.fromJson(Map<String, dynamic> map) {
    return HealthRecordModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      systolic: map['systolic'] as String,
      diastolic: map['diastolic'] as String,
      pulse: map['pulse'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
    );
  }

  HealthRecordModel copyWith({
    String? id,
    String? userId,
    String? systolic,
    String? diastolic,
    String? pulse,
    String? date,
    String? time,
  }) {
    return HealthRecordModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
