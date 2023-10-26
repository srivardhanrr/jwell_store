import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwell_store/features/auth/domain/usecases/oAuthLogin.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/send_email_instructions.dart';
import '../states/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  Login loginUseCase;
  OAuthLogin oAuthLoginUseCase;
  Register registerUseCase;
  Logout logoutUseCase;
  GetUser getUserUseCase;
  SendEmailInstructions sendEmailInstructionsUseCase;
  AuthController({
    required this.loginUseCase,
    required this.oAuthLoginUseCase,
    required this.registerUseCase,
    required this.getUserUseCase,
    required this.logoutUseCase,
    required this.sendEmailInstructionsUseCase,
  }) : super(LoginInitial());

  Future<void> getUser() async {
    state = LoggingIn();

    final response = await getUserUseCase();

    response.fold((failure) {
      state = LoginFailed(failure);
    }, (User user) {
      state = Authenticated(user);
    });
  }

  void oAuthLogin({required String provider}) async {
    state = LoggingIn();
    final response = await oAuthLoginUseCase(OAuthParams(provider: provider));
    response.fold((failure) {
      state = LoginFailed(failure);
    }, (User user) {
      state = Authenticated(user);
    });
  }

  void login({
    required String email,
    required String password,
  }) async {
    state = LoggingIn();

    final response = await loginUseCase(LoginParams(
      email: email,
      password: password,
    ));

    response.fold((failure) {
      state = LoginFailed(failure);
    }, (User user) {
      state = Authenticated(
        user,
      );
    });
  }

  void register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = Registering();

    final response = await registerUseCase(RegisterParams(
      fullName: fullName,
      email: email,
      password: password,
    ));

    response.fold((failure) {
      state = RegistrationFailed(failure);
    }, (_) {
      state = RegistrationSuccessful();
    });
  }

  Future<void> logout() async {
    state = LoggingIn();
    final response = await logoutUseCase();
    response.fold((failure) {
      state = LoginFailed(failure);
    }, (success) {
      state = Unauthenticated();
    });
  }

  void sendEmailInstructions({required String email}) async {
    state = SendingInstructions();

    final response = await sendEmailInstructionsUseCase(
      SendEmailInstructionsParams(email: email),
    );

    response.fold((failure) {
      state = SendingInstructionsFailed(failure);
    }, (_) {
      state = SendingInstructionsSuccessful();
    });
  }
}

final authStateProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>((ref) {
  var registerUseCase = ref.watch(registerUseCaseProvider);
  var loginUseCase = ref.watch(loginUseCaseProvider);
  var oAuthLoginUseCase = ref.watch(oAuthLoginUseCaseProvider);
  var getUserUseCase = ref.watch(getAuthDataUseCaseProvider);
  var logoutUseCase = ref.watch(logOutUseCaseProvider);
  var sendEmailInstructionsUseCase =
      ref.watch(sendEmailInstructionsUseCaseProvider);

  return AuthController(
    registerUseCase: registerUseCase,
    oAuthLoginUseCase: oAuthLoginUseCase,
    loginUseCase: loginUseCase,
    getUserUseCase: getUserUseCase,
    logoutUseCase: logoutUseCase,
    sendEmailInstructionsUseCase: sendEmailInstructionsUseCase,
  );
});
