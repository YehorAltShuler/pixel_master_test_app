import 'package:fpdart/fpdart.dart';
import 'package:pixel_master_test_app/core/error/exceptions.dart';
import 'package:pixel_master_test_app/core/network/connection_checker.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/health_record.dart';
import '../../domain/repositories/health_record_repository.dart';
import '../datasources/health_record_local_data_source.dart';
import '../datasources/health_record_remote_data_source.dart';
import '../models/record_model.dart';

class HealthRecordRepositoryImpl implements HealthRecordRepository {
  final HealthRecordRemoteDataSource _healthRecordRemoteDataSource;
  final HealthRecordLocalDataSource _healthRecordLocalDataSource;
  final ConnectionChecker _connectionChecker;

  HealthRecordRepositoryImpl(
    this._healthRecordRemoteDataSource,
    this._healthRecordLocalDataSource,
    this._connectionChecker,
  );

  @override
  Future<Either<Failure, HealthRecord>> uploadHealthRecord({
    required String userId,
    required String systolic,
    required String diastolic,
    required String pulse,
    required String date,
    required String time,
  }) async {
    try {
      if (!await _connectionChecker.isConnected) {
        return left(Failure('No internet connection'));
      }
      HealthRecordModel healthRecordModel = HealthRecordModel(
        id: const Uuid().v1(),
        userId: userId,
        systolic: systolic,
        diastolic: diastolic,
        pulse: pulse,
        date: date,
        time: time,
      );
      final uploadedHealthRecord = await _healthRecordRemoteDataSource
          .uploadHealthRecord(healthRecordModel);
      return right(uploadedHealthRecord);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<HealthRecord>>> getHealthRecords(
      {required String userId}) async {
    try {
      if (!await _connectionChecker.isConnected) {
        final localHealthRecords =
            _healthRecordLocalDataSource.loadLocalHealthRecords();
        return right(localHealthRecords);
      }
      final healthRecords =
          await _healthRecordRemoteDataSource.getHealthRecords(userId);
      _healthRecordLocalDataSource.uploadLocalHealthRecords(healthRecords);
      return right(healthRecords);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHealthRecord(
      {required String recordId}) async {
    try {
      if (!await _connectionChecker.isConnected) {
        _healthRecordLocalDataSource.deleteLocalHealthRecord(recordId);
      }
      await _healthRecordRemoteDataSource.deleteHealthRecord(recordId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
