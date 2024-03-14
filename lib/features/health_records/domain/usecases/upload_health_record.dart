import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/health_record.dart';
import '../repositories/health_record_repository.dart';

class UploadHealthRecord
    implements UseCase<HealthRecord, UploadHealthRecordParams> {
  final HealthRecordRepository _healthRecordRepository;

  UploadHealthRecord(this._healthRecordRepository);
  @override
  Future<Either<Failure, HealthRecord>> call(
      UploadHealthRecordParams params) async {
    return await _healthRecordRepository.uploadHealthRecord(
        userId: params.userId,
        systolic: params.systolic,
        diastolic: params.diastolic,
        pulse: params.pulse,
        date: params.date,
        time: params.time);
  }
}

class UploadHealthRecordParams {
  final String userId;
  final String systolic;
  final String diastolic;
  final String pulse;
  final String date;
  final String time;

  UploadHealthRecordParams({
    required this.userId,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.date,
    required this.time,
  });
}
