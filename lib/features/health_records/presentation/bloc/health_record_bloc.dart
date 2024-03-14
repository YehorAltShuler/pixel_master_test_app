import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/features/health_records/domain/usecases/get_health_records.dart';

import '../../domain/entities/health_record.dart';
import '../../domain/usecases/delete_health_record.dart';
import '../../domain/usecases/upload_health_record.dart';

part 'health_record_event.dart';
part 'health_record_state.dart';

class HealthRecordBloc extends Bloc<HealthRecordEvent, HealthRecordState> {
  final UploadHealthRecord _uploadHealthRecord;
  final GetHealthRecords _getHealthRecords;
  final DeleteHealthRecord _deleteHealthRecord;
  HealthRecordBloc(
      {required UploadHealthRecord uploadHealthRecord,
      required GetHealthRecords getHealthRecords,
      required DeleteHealthRecord deleteHealthRecord})
      : _uploadHealthRecord = uploadHealthRecord,
        _getHealthRecords = getHealthRecords,
        _deleteHealthRecord = deleteHealthRecord,
        super(HealthRecordInitial()) {
    on<HealthRecordEvent>((event, emit) => emit(HealthRecordLoading()));
    on<HealthRecordUploadEvent>(_onHealthRecordUpload);
    on<HealthRecordFetchEvent>(_onFetchAllHealthRecords);
    on<HealthRecordDeleteEvent>(_onHealthRecordDelete);
  }

  void _onHealthRecordDelete(
    HealthRecordDeleteEvent event,
    Emitter<HealthRecordState> emit,
  ) async {
    final response = await _deleteHealthRecord(event.healthRecordId);

    response.fold(
      (failure) => emit(HealthRecordFailure(failure.message)),
      (success) => emit(HealthRecordDeleteSuccess()),
    );
  }

  void _onHealthRecordUpload(
    HealthRecordUploadEvent event,
    Emitter<HealthRecordState> emit,
  ) async {
    final response = await _uploadHealthRecord(
      UploadHealthRecordParams(
        userId: event.userId,
        systolic: event.systolic,
        diastolic: event.diastolic,
        pulse: event.pulse,
        date: event.date,
        time: event.time,
      ),
    );

    response.fold(
      (failure) => emit(HealthRecordFailure(failure.message)),
      (success) => emit(HealthRecordUploadSuccess()),
    );
  }

  void _onFetchAllHealthRecords(
    HealthRecordFetchEvent event,
    Emitter<HealthRecordState> emit,
  ) async {
    final response = await _getHealthRecords(event.userId);

    response.fold(
      (failure) => emit(HealthRecordFailure(failure.message)),
      (healthRecords) => emit(HealthRecordDisplaySuccess(healthRecords)),
    );
  }
}
