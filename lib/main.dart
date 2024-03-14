import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixel_master_test_app/application.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/bloc/health_record_bloc.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initializedDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeCubit>(
        create: (_) => serviceLocator<ThemeCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<HealthRecordBloc>(),
      ),
    ],
    child: const Application(),
  ));
}
