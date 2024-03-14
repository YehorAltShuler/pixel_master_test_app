part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserLoading extends AppUserState {}

final class AppUserSignedIn extends AppUserState {
  final User user;

  const AppUserSignedIn(this.user);
}

final class AppUserError extends AppUserState {
  final String error;

  const AppUserError(this.error);
}

final class AppUserSignedOut extends AppUserState {}

final class AppUserAccountDeleted extends AppUserState {}
