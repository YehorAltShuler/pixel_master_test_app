import 'package:fpdart/fpdart.dart';
import 'package:pixel_master_test_app/core/error/failures.dart';
import 'package:pixel_master_test_app/features/health_records/domain/entities/health_record.dart';

abstract interface class HealthRecordRepository {
  Future<Either<Failure, HealthRecord>> uploadHealthRecord({
    required String userId,
    required String systolic,
    required String diastolic,
    required String pulse,
    required String date,
    required String time,
  });

  Future<Either<Failure, List<HealthRecord>>> getHealthRecords({
    required String userId,
  });

  Future<Either<Failure, void>> deleteHealthRecord({
    required String recordId,
  });
}
