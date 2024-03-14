import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:pixel_master_test_app/core/constants/app_colors.dart';
import 'package:pixel_master_test_app/core/constants/app_font_styles.dart';
import 'package:pixel_master_test_app/core/utils/show_snackbar.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/bloc/health_record_bloc.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/widgets/custom_list_wheel.dart';
import 'package:pixel_master_test_app/core/common/widgets/custom_button.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/loader.dart';

class AddNewRecord extends StatefulWidget {
  static const String routeName = 'add-new-record';
  static const String routePath = 'add-new-record';
  const AddNewRecord({super.key});

  @override
  State<AddNewRecord> createState() => _AddNewRecordState();
}

class _AddNewRecordState extends State<AddNewRecord> {
  int systolicPressure = 120;
  int diastolicPressure = 80;
  int pulse = 60;
  String date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  late String time;

  @override
  void didChangeDependencies() {
    time = TimeOfDay.now().format(context);
    super.didChangeDependencies();
  }

  void _uploadHealthRecord() {
    final userId =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user.id;
    context.read<HealthRecordBloc>().add(
          HealthRecordUploadEvent(
            userId: userId,
            systolic: systolicPressure.toString(),
            diastolic: diastolicPressure.toString(),
            pulse: pulse.toString(),
            date: date,
            time: time,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: _uploadHealthRecord,
            icon: const Icon(
              Icons.done,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: BlocConsumer<HealthRecordBloc, HealthRecordState>(
        listener: (context, state) {
          if (state is HealthRecordFailure) {
            showErrorSnackBar(context, state.error);
          } else if (state is HealthRecordUploadSuccess) {
            context.read<HealthRecordBloc>().add(
                  HealthRecordFetchEvent(
                    userId:
                        (context.read<AppUserCubit>().state as AppUserSignedIn)
                            .user
                            .id,
                  ),
                );
            showSuccessSnackBar(context, 'Record added successfully');
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is HealthRecordLoading) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSystolic(),
                    _buildDiastolic(),
                    _buildPulse(),
                  ],
                ),
                _buildDateAndTime(),
              ],
            ),
          );
        },
      ),
    );
  }

  Column _buildDateAndTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date & Time', style: AppFontStyles.h1(context)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CustomButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text(date),
                  ],
                ),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(
                      const Duration(days: 1825),
                    ),
                  ).then((value) {
                    setState(() {
                      value == null
                          ? null
                          : date = DateFormat('dd/MM/yyyy').format(value);
                    });
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 8),
                    Text(time),
                  ],
                ),
                onPressed: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((value) {
                    setState(() {
                      value == null ? null : time = value.format(context);
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildSystolic() {
    return Column(
      children: [
        Text(
          'Systolic',
          style: AppFontStyles.h2(context),
        ),
        const SizedBox(height: 4),
        Text(
          '(mmHg)',
          style: AppFontStyles.h4(context),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          width: 50,
          child: CustomListWheel(
            initialItem: 120,
            onSelectedItemChanged: (index) {
              setState(() {
                systolicPressure = index;
              });
            },
            children: List.generate(281, (index) {
              return Text(
                '$index',
                style: AppFontStyles.h2(context),
              );
            }),
          ),
        ),
      ],
    );
  }

  Column _buildDiastolic() {
    return Column(
      children: [
        Text(
          'Diastolic',
          style: AppFontStyles.h2(context),
        ),
        const SizedBox(height: 4),
        Text(
          '(mmHg)',
          style: AppFontStyles.h4(context),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          width: 50,
          child: CustomListWheel(
            initialItem: 80,
            onSelectedItemChanged: (index) {
              setState(() {
                diastolicPressure = index;
              });
            },
            children: List.generate(281, (index) {
              return Text(
                '$index',
                style: AppFontStyles.h2(context),
              );
            }),
          ),
        ),
      ],
    );
  }

  Column _buildPulse() {
    return Column(
      children: [
        Text(
          'Pulse',
          style: AppFontStyles.h2(context),
        ),
        const SizedBox(height: 4),
        Text(
          '(BPM)',
          style: AppFontStyles.h4(context),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          width: 50,
          child: CustomListWheel(
            initialItem: 60,
            onSelectedItemChanged: (index) {
              setState(() {
                pulse = index;
              });
            },
            children: List.generate(281, (index) {
              return Text(
                '$index',
                style: AppFontStyles.h2(context),
              );
            }),
          ),
        )
      ],
    );
  }
}
