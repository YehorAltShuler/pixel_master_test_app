import 'package:fpdart/fpdart.dart';
import 'package:pixel_master_test_app/core/error/exceptions.dart';
import 'package:pixel_master_test_app/core/error/failures.dart';
import 'package:pixel_master_test_app/core/common/entities/user.dart';
import 'package:pixel_master_test_app/core/network/connection_checker.dart';
import 'package:pixel_master_test_app/features/auth/data/models/user_model.dart';
import 'package:pixel_master_test_app/features/auth/domain/repository/auth_repository.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectionChecker _connectionChecker;

  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._connectionChecker,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    // TODO: check this strange approach
    try {
      if (!await _connectionChecker.isConnected) {
        final session = _authRemoteDataSource.curentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await _authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User is not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await _authRemoteDataSource.signInWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await _authRemoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await _connectionChecker.isConnected) {
        return left(Failure('No internet connection!'));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
