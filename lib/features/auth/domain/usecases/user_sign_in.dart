import 'package:fpdart/fpdart.dart';
import 'package:pixel_master_test_app/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/common/entities/user.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository _authRepository;

  UserSignIn(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await _authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
