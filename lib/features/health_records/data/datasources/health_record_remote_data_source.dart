import 'package:pixel_master_test_app/core/error/exceptions.dart';
import 'package:pixel_master_test_app/features/health_records/data/models/record_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class HealthRecordRemoteDataSource {
  Future<HealthRecordModel> uploadHealthRecord(HealthRecordModel healthRecord);

  Future<List<HealthRecordModel>> getHealthRecords(String userId);

  Future<void> deleteHealthRecord(String recordId);
}

class HealthRecordRemoteDataSourceImpl implements HealthRecordRemoteDataSource {
  final SupabaseClient _supabaseClient;
  HealthRecordRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<HealthRecordModel> uploadHealthRecord(
      HealthRecordModel healthRecord) async {
    try {
      final healthRecordData = await _supabaseClient
          .from('pulse_and_pressure_records')
          .insert(healthRecord.toJson())
          .select();

      return HealthRecordModel.fromJson(healthRecordData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<HealthRecordModel>> getHealthRecords(String userId) async {
    try {
      final healthRecords = await _supabaseClient
          .from('pulse_and_pressure_records')
          .select()
          .eq('user_id', userId);
      return healthRecords
          .map((record) => HealthRecordModel.fromJson(record))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteHealthRecord(String recordId) {
    try {
      return _supabaseClient
          .from('pulse_and_pressure_records')
          .delete()
          .eq('id', recordId);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
