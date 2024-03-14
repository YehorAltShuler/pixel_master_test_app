part of 'health_record_bloc.dart';

@immutable
sealed class HealthRecordState {
  const HealthRecordState();
}

final class HealthRecordInitial extends HealthRecordState {}

final class HealthRecordLoading extends HealthRecordState {}

final class HealthRecordFailure extends HealthRecordState {
  final String error;
  const HealthRecordFailure(this.error);
}

final class HealthRecordDeleteSuccess extends HealthRecordState {}

final class HealthRecordUploadSuccess extends HealthRecordState {}

final class HealthRecordDisplaySuccess extends HealthRecordState {
  final List<HealthRecord> healthRecords;
  const HealthRecordDisplaySuccess(this.healthRecords);
}
