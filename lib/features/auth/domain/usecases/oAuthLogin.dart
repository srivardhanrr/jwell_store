import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../validators/login_validator.dart';

class OAuthLogin extends UseCase<User, OAuthParams> {
  AuthRepository repository;
  LoginValidator validator;
  OAuthLogin({
    required this.repository,
    required this.validator,
  });
  @override
  Future<Either<Failure, User>> call(OAuthParams params) async {
    return repository.oAuthLogin(params.provider);
  }
}

class OAuthParams {
  String provider;

  OAuthParams({
    required this.provider,
  });
}

final oAuthLoginUseCaseProvider = Provider.autoDispose<OAuthLogin>((ref) {
  return OAuthLogin(
    repository: ref.watch(authRepositoryProvider),
    validator: ref.watch(loginValidatorProvider),
  );
});
