import 'package:fpdart/fpdart.dart';
import 'package:pixel_master_test_app/core/error/failures.dart';
import 'package:pixel_master_test_app/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
