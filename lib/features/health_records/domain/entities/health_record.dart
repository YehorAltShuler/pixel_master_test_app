class HealthRecord {
  final String id;
  final String userId;
  final String systolic;
  final String diastolic;
  final String pulse;
  final String date;
  final String time;

  HealthRecord({
    required this.id,
    required this.userId,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.date,
    required this.time,
  });
}
