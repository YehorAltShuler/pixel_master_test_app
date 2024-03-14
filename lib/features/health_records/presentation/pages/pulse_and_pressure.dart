import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_master_test_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:pixel_master_test_app/core/common/widgets/loader.dart';
import 'package:pixel_master_test_app/core/constants/app_colors.dart';
import 'package:pixel_master_test_app/core/constants/app_constants.dart';
import 'package:pixel_master_test_app/core/constants/app_font_styles.dart';
import 'package:pixel_master_test_app/core/utils/show_snackbar.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/bloc/health_record_bloc.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/widgets/health_record_card.dart';
import 'package:pixel_master_test_app/init_dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/custom_drawer.dart';

class PulseAndPressure extends StatefulWidget {
  static const String routeName = 'pulse-and-pressure';
  static const String routePath = '/pulse-and-pressure';
  const PulseAndPressure({super.key});

  @override
  State<PulseAndPressure> createState() => _PulseAndPressureState();
}

class _PulseAndPressureState extends State<PulseAndPressure> {
  //TODO: Fix this implementation
  @override
  void initState() {
    final userId = serviceLocator<SupabaseClient>().auth.currentUser?.id;
    context
        .read<HealthRecordBloc>()
        .add(HealthRecordFetchEvent(userId: userId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('add-new-record'),
        child: const Icon(Icons.add),
      ),
      drawer: const CustomDrawer(),
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
