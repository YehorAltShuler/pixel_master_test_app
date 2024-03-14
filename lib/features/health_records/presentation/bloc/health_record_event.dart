part of 'health_record_bloc.dart';

@immutable
sealed class HealthRecordEvent {
  const HealthRecordEvent();
}

final class HealthRecordUploadEvent extends HealthRecordEvent {
  final String userId;
  final String systolic;
  final String diastolic;
  final String pulse;
  final String date;
  final String time;

  const HealthRecordUploadEvent({
    required this.userId,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.date,
    required this.time,
  });
}

final class HealthRecordDeleteEvent extends HealthRecordEvent {
  final String healthRecordId;

  const HealthRecordDeleteEvent({
    required this.healthRecordId,
  });
}

final class HealthRecordFetchEvent extends HealthRecordEvent {
  final String userId;

  const HealthRecordFetchEvent({
    required this.userId,
  });
}
