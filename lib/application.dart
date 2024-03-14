import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'core/theme/cubit/theme_cubit.dart';
import 'core/navigation/navigation.dart';

class Application extends StatefulWidget {
  static const String _title = 'HealthTrack: Pulse & Pressure';

  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserSignedIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: Application._title,
          theme: context.read<ThemeCubit>().theme,
          debugShowCheckedModeBanner: false,
          routerConfig: Navigation.routerConfig,
        );
      },
    );
  }
}
