import 'package:fpdart/fpdart.dart';
import 'package:pixel_master_test_app/core/common/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository _authRepository;
  const UserSignUp(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await _authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
