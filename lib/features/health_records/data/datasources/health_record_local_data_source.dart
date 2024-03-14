import 'package:hive/hive.dart';
import '../models/record_model.dart';

abstract interface class HealthRecordLocalDataSource {
  void uploadLocalHealthRecords(List<HealthRecordModel> healthRecords);
  List<HealthRecordModel> loadLocalHealthRecords();
  void deleteLocalHealthRecord(String recordId);
  void addLocalHealthRecord(HealthRecordModel healthRecord);
}

class HealthRecordLocalDataSourceImpl implements HealthRecordLocalDataSource {
  final Box _box;

  HealthRecordLocalDataSourceImpl(this._box);

  @override
  List<HealthRecordModel> loadLocalHealthRecords() {
    List<HealthRecordModel> healthRecords = [];
    _box.read(() {
      for (int i = 0; i < _box.length; i++) {
        healthRecords.add(HealthRecordModel.fromJson(_box.get(i.toString())));
      }
    });

    return healthRecords;
  }

  @override
  void uploadLocalHealthRecords(List<HealthRecordModel> healthRecords) {
    _box.clear();
    _box.write(() {
      for (int i = 0; i < healthRecords.length; i++) {
        _box.put(healthRecords[i].id, healthRecords[i].toJson());
      }
    });
  }

  @override
  void deleteLocalHealthRecord(String recordId) {
    _box.delete(recordId);
  }

  @override
  void addLocalHealthRecord(HealthRecordModel healthRecord) {
    _box.put(healthRecord.id, healthRecord.toJson());
  }
}
