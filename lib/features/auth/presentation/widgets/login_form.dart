import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:jwell_store/utils/utils.dart';
import 'package:jwell_store/widgets/primary_button.dart';

import '../../../../config/styles.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../domain/validators/failures.dart';
import '../../domain/validators/login_validator.dart';
import '../controllers/auth_controller.dart';
import '../screens/register_screen.dart';
import '../states/auth_state.dart';
import 'google_button.dart';
import 'or_with.dart';
import 'password_input.dart';
import 'register_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? mapValidationFailureToMessage(
      BuildContext context, ValidationFailure? validationFailure) {
    if (validationFailure is RequiredPasswordFailure) {
      return "Password is required";
    }

    if (validationFailure is PasswordLengthFailure) {
      return "Password is too short";
    }

    if (validationFailure is RequiredEmailFailure) {
      return "Email is required";
    }

    if (validationFailure is RequiredNameFailure) {
      return "Name is required";
    }

    if (validationFailure != null) {
      return "Invalid input";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authStateProvider,
      (previous, state) {
        if (state is LoginFailed) {
          state.failure.showSnackBar(context);
        }
        if (state is Authenticated) {
          context.showSuccessSnackBar(
            "Welcome ${state.user.firstName}",
          );
          context.go(HomeScreen.routePath);
        }
      },
    );

    final authController = ref.watch(authStateProvider.notifier);
    final authState = ref.watch(authStateProvider);
    final loginValidator = ref.watch(loginValidatorProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final validationFailure =
                    loginValidator.validatePassword(value!);
                return mapValidationFailureToMessage(
                    context, validationFailure);
              },
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                hintText: "Email",
                suffixIconColor: Color(Colors.grey.value),
                border: defaultInputBorder,
                enabledBorder: defaultInputBorder,
                focusedBorder: defaultInputBorder,
              ),
            ),
            const SizedBox(height: 10),
            PasswordInput(
              hintText: "Password",
              controller: passwordController,
              validator: (value) {
                final validationFailure =
                    loginValidator.validatePassword(value!);
                return mapValidationFailureToMessage(
                    context, validationFailure);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => context.push(ForgotPasswordScreen.routePath),
                child: Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              isLoading: authState is LoggingIn,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  authController.login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                }
              },
              title: 'Login',
            ),
            const SizedBox(
              height: 20,
            ),
            const OrWith(
              text: "login",
            ),
            const SizedBox(
              height: 20,
            ),
            GoogleButton(
              onTap: () {
                authController.oAuthLogin(provider: "google");
              },
              title: 'Login with Google',
            ),
            const SizedBox(
              height: 30,
            ),
            AccountAvailabilityWidget(
              text: "Don't have an account?",
              actionText: "Sign up",
              onTap: () => context.push(RegisterScreen.routePath),
            ),
          ],
        ),
      ),
    );
  }
}
