import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_master_test_app/core/utils/show_snackbar.dart';
import 'package:pixel_master_test_app/features/auth/presentation/pages/auth_screen.dart';

import '../../../../core/common/cubits/app_user_cubit/app_user_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_font_styles.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../init_dependencies.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state is AppUserSignedOut) {
          context.goNamed(AuthScreen.routeName);
          showSuccessSnackBar(context, 'Signed out successfully!');
        }
        if (state is AppUserAccountDeleted) {
          context.goNamed(AuthScreen.routeName);
          showSuccessSnackBar(context, 'Account deleted successfully!');
        }
      },
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary,
                      child: Image.asset(AppConstants.user),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serviceLocator<SharedPreferencesService>()
                                  .userName,
                              style: AppFontStyles.h2(context),
                            ),
                            Text(
                              serviceLocator<SharedPreferencesService>()
                                  .userEmail,
                              style: AppFontStyles.h4(context),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () =>
                              context.read<ThemeCubit>().switchTheme(),
                          icon: brightness == Brightness.dark
                              ? const Icon(
                                  CupertinoIcons.moon_stars,
                                  color: AppColors.white,
                                )
                              : const Icon(
                                  CupertinoIcons.sun_max,
                                  color: AppColors.black,
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _buildLogOutButton(context),
            _buildDeleteAccountButton(context),
          ],
        ),
      ),
    );
  }

  ListTile _buildLogOutButton(BuildContext context) {
    return ListTile(
      title: Text(
        'Log Out',
        style: AppFontStyles.h3(context),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Log Out?', style: AppFontStyles.h3(context)),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AppUserCubit>().signOut();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
      },
    );
  }

  ListTile _buildDeleteAccountButton(BuildContext context) {
    return ListTile(
      title: Text(
        'Delete Account',
        style: AppFontStyles.h3(context).copyWith(
          color: AppColors.errorRed.withOpacity(0.75),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete Account?', style: AppFontStyles.h3(context)),
              content: Text('This action cannot be undone',
                  style: AppFontStyles.h4(context)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AppUserCubit>().deleteAccount();
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: AppColors.errorRed),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
