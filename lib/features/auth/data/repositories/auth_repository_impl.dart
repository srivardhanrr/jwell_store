import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwell_store/features/auth/data/data.dart';
import 'package:jwell_store/utils/utils.dart';

import '../../domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthLocalDataSource localDataSource;
  AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login(
    String email,
    String password,
  ) async {
    return ErrorHandler<User>().handleExceptions(() async {
      var userModel = await remoteDataSource.loginWithEmail(
        email,
        password,
      );

      await localDataSource.save(userModel);

      UserModel model = await localDataSource.getUser();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> register(
    String name,
    String email,
    String password,
  ) {
    return ErrorHandler<void>().handleExceptions(() async {
      await remoteDataSource.registerAccount(
        name,
        email,
        password,
      );
    });
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    return ErrorHandler<User>().handleExceptions(() async {
      UserModel model = await localDataSource.getUser();
      return model.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return ErrorHandler<void>().handleExceptions(() async {
      await remoteDataSource.logout();
      await localDataSource.clear();
    });
  }

  @override
  Future<Either<Failure, void>> sendEmailInstructions(String email) {
    return ErrorHandler<void>().handleExceptions(() async {
      await remoteDataSource.sendEmailInstructions(email);
    });
  }

  @override
  Future<Either<Failure, User>> oAuthLogin(String provider) async {
    return ErrorHandler<User>().handleExceptions(() async {
      var userModel = await remoteDataSource.oAuthLogin(
        provider,
      );

      await localDataSource.save(userModel);

      UserModel model = await localDataSource.getUser();
      return model.toEntity();
    });
  }
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  var localDataSource = ref.watch(authLocalDataSourceProvider);

  var remoteDataSource = ref.watch(authRemoteDataSourceProvider);

  return AuthRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
});
