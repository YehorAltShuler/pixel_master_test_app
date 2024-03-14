import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import '../../../../init_dependencies.dart';
import '../../../services/shared_preferences_service.dart';
import '../../entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final SupabaseClient _supabase;
  AppUserCubit(this._supabase) : super(AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserSignedIn(user));
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      emit(AppUserSignedOut());
      setSignedOut();
    } catch (e) {
      emit(AppUserError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    try {
      final supabaseAdmin = SupabaseClient(
          dotenv.env['SUPABASE_URL']!, dotenv.env['SERVICE_ROLE_KEY']!);
      final String userId = _supabase.auth.currentUser!.id;
      await supabaseAdmin.auth.admin.deleteUser(userId);
      emit(AppUserAccountDeleted());
      setSignedOut();
    } catch (e) {
      emit(AppUserError(e.toString()));
    }
  }

  void setSignedOut() async {
    serviceLocator<SharedPreferencesService>().isUserLoggedIn = false;
  }
}
