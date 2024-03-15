import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_font_styles.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/health_record_bloc.dart';
import '../widgets/health_record_card.dart';

class History extends StatelessWidget {
  static const String routeName = 'history';
  static const String routePath = 'history';
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<HealthRecordBloc, HealthRecordState>(
        listener: (context, state) {
          if (state is HealthRecordFailure) {
            showErrorSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is HealthRecordLoading) {
            return const Loader();
          }
          if (state is HealthRecordDisplaySuccess &&
              state.healthRecords.isNotEmpty) {
            return ListView.builder(
                itemCount: state.healthRecords.length,
                itemBuilder: (context, index) {
                  final healthRecord = state.healthRecords[index];
                  return Dismissible(
                    onDismissed: (direction) {
                      context.read<HealthRecordBloc>().add(
                          HealthRecordDeleteEvent(
                              healthRecordId: healthRecord.id));
                    },
                    key: ValueKey(state.healthRecords[index]),
                    background: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.errorRed.withOpacity(0.75),
                        ),
                        child: const Icon(Icons.delete),
                      ),
                    ),
                    child: HealthRecordCard(
                      healthRecord,
                    ),
                  );
                });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Oops! No records found',
                style: AppFontStyles.h1(context),
              ),
              Text(
                'Try adding a new record to see it here.',
                style: AppFontStyles.h2(context),
              ),
              Image.asset(AppConstants.addNotes),
            ],
          );
        },
      ),
    );
  }
}
