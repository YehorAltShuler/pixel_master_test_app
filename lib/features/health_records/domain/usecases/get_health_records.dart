import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/health_record.dart';
import '../repositories/health_record_repository.dart';

class GetHealthRecords implements UseCase<List<HealthRecord>, String> {
  final HealthRecordRepository _healthRecordRepository;

  GetHealthRecords(this._healthRecordRepository);
  @override
  Future<Either<Failure, List<HealthRecord>>> call(String params) async {
    return await _healthRecordRepository.getHealthRecords(userId: params);
  }
}
