import 'package:appwrite/appwrite.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwell_store/config/client.dart';
import 'package:jwell_store/utils/utils.dart';

import '../../../../config/constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail(
    String email,
    String password,
  );

  Future<UserModel> oAuthLogin(
    String provider,
  );

  Future<void> registerAccount(
    String fullName,
    String email,
    String password,
  );

  Future<void> logout();

  Future<void> sendEmailInstructions(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Account account;
  NetworkInfo networkInfo;
  AuthRemoteDataSourceImpl({required this.account, required this.networkInfo});

  @override
  Future<UserModel> loginWithEmail(
    String email,
    String password,
  ) async {
    return ErrorHandler<UserModel>().handleErrors(() async {
      await account.createEmailSession(
        email: email,
        password: password,
      );

      var user = await account.get();

      UserModel authData = UserModel(
        id: user.$id,
        email: user.email,
        fullName: user.name,
        isVerified: user.emailVerification,
      );

      return authData;
    });
  }

  @override
  Future<UserModel> oAuthLogin(String provider) async {
    return ErrorHandler<UserModel>().handleErrors(() async {
      await account.createOAuth2Session(provider: provider);

      var user = await account.get();

      UserModel authData = UserModel(
        id: user.$id,
        email: user.email,
        fullName: user.name,
        isVerified: user.emailVerification,
      );

      return authData;
    });
  }

  @override
  Future<void> registerAccount(
    String fullName,
    String email,
    String password,
  ) async {
    return ErrorHandler<void>().handleErrors(() async {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: fullName,
      );
    });
  }

  @override
  Future<void> sendEmailInstructions(String email) {
    return ErrorHandler<void>().handleErrors(() async {
      await account.createRecovery(
        email: email,
        url: siteUrl,
      );
    });
  }

  @override
  Future<void> logout() {
    return ErrorHandler<void>().handleErrors(() async {
      var session = await account.getSession(sessionId: 'current');
      await account.deleteSession(sessionId: session.$id);
    });
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  var account = ref.watch(accountProvider);
  return AuthRemoteDataSourceImpl(
    account: account,
    networkInfo: ref.watch(networkInfoProvider),
  );
});
