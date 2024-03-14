import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/health_record_repository.dart';

class DeleteHealthRecord implements UseCase<void, String> {
  final HealthRecordRepository _healthRecordRepository;

  DeleteHealthRecord(this._healthRecordRepository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _healthRecordRepository.deleteHealthRecord(recordId: params);
  }
}
