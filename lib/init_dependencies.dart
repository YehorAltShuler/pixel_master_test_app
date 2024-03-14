import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixel_master_test_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:pixel_master_test_app/core/network/connection_checker.dart';
import 'package:pixel_master_test_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pixel_master_test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pixel_master_test_app/features/auth/domain/repository/auth_repository.dart';
import 'package:pixel_master_test_app/features/auth/domain/usecases/current_user.dart';
import 'package:pixel_master_test_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:pixel_master_test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pixel_master_test_app/features/health_records/data/datasources/health_record_local_data_source.dart';
import 'package:pixel_master_test_app/features/health_records/data/datasources/health_record_remote_data_source.dart';
import 'package:pixel_master_test_app/features/health_records/domain/usecases/get_health_records.dart';
import 'package:pixel_master_test_app/features/health_records/domain/usecases/upload_health_record.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/shared_preferences_service.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/health_records/data/repositories/health_record_repsitory_impl.dart';
import 'features/health_records/domain/repositories/health_record_repository.dart';
import 'features/health_records/domain/usecases/delete_health_record.dart';
import 'features/health_records/presentation/bloc/health_record_bloc.dart';

final serviceLocator = GetIt.instance;

// Future<void> initializedDependencies() async {
//   final sharedPreferencesService = await SharedPreferencesService.getInstance();
//   serviceLocator.registerSingleton(sharedPreferencesService);

//   //Dependencies
//   serviceLocator.registerFactory<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl(serviceLocator()));

//   serviceLocator.registerFactory<AuthRepository>(
//       () => AuthRepositoryImpl(serviceLocator()));

//   serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

//   serviceLocator
//       .registerLazySingleton(() => AuthBloc(userSignUp: serviceLocator()));

//   serviceLocator.registerFactory<ThemeCubit>(() => ThemeCubit());
// }

Future<void> initializedDependencies() async {
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  serviceLocator.registerSingleton(sharedPreferencesService);
  serviceLocator.registerFactory<ThemeCubit>(() => ThemeCubit());

  _initAuth();
  _initHealthRecords();

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'health_records'));

  serviceLocator.registerFactory(() => InternetConnection());
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit(serviceLocator()));
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  serviceLocator

    //Data sources
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))

    //Repositories
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator(), serviceLocator()))

    //Use cases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))

    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initHealthRecords() {
  serviceLocator

    //Data sources
    ..registerFactory<HealthRecordRemoteDataSource>(
        () => HealthRecordRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<HealthRecordLocalDataSource>(
        () => HealthRecordLocalDataSourceImpl(serviceLocator()))

    //Repositories
    ..registerFactory<HealthRecordRepository>(() => HealthRecordRepositoryImpl(
        serviceLocator(), serviceLocator(), serviceLocator()))

    //Use cases
    ..registerFactory(() => UploadHealthRecord(serviceLocator()))
    ..registerFactory(() => GetHealthRecords(serviceLocator()))
    ..registerFactory(() => DeleteHealthRecord(serviceLocator()))

    //Bloc
    ..registerLazySingleton(() => HealthRecordBloc(
          uploadHealthRecord: serviceLocator(),
          getHealthRecords: serviceLocator(),
          deleteHealthRecord: serviceLocator(),
        ));
}
