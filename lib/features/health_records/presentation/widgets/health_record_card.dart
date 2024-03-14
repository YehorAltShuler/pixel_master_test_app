import 'package:flutter/material.dart';
import 'package:pixel_master_test_app/core/constants/app_colors.dart';
import 'package:pixel_master_test_app/core/constants/app_font_styles.dart';
import 'package:pixel_master_test_app/features/health_records/domain/entities/health_record.dart';

class HealthRecordCard extends StatelessWidget {
  const HealthRecordCard(this.healthRecord, {super.key});
  final HealthRecord healthRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  healthRecord.systolic,
                  style: AppFontStyles.h2(context),
                ),
                Text(
                  healthRecord.diastolic,
                  style: AppFontStyles.h2(context),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: VerticalDivider(
                color: AppColors.primary,
                thickness: 2,
              ),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${healthRecord.time}, ${healthRecord.date}'),
            Text('${healthRecord.pulse} BPM'),
          ],
        ),
      ),
    );
  }
}
