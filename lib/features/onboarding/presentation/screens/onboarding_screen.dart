import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/config/constants.dart';
import 'package:jwell_store/utils/utils.dart';

import '../../../../config/images.dart';
import '../../../../widgets/primary_button.dart';
import '../../../auth/auth.dart';
import '../controllers/onboarding_controller.dart';
import '../states/onboarding_state.dart';

class OnboardingScreen extends ConsumerWidget {
  static String routePath = "/intro";
  const OnboardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(Images.personWorking)),
                        const SizedBox(height: 20),
                        Text(
                          "Welcome to $appTitle",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your one stop for all your jewellery needs, with a wide range of products to choose from.",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        const ContinueButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends ConsumerWidget {
  const ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(onboardingStateProvider, (previous, next) {
      if (next is OnboardingCompleted) {
        context.go(LoginScreen.routePath);
      }

      if (next is OnboardingError) {
        next.failure.showSnackBar(context);
      }
    });

    var onboardingController = ref.watch(onboardingStateProvider.notifier);
    var onBoardingState = ref.watch(onboardingStateProvider);

    if (onBoardingState is OnboardingLoading) {
      return const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      );
    }

    return PrimaryButton(
      onTap: () {
        onboardingController.completeOnboarding();
      },
      title: "Continue",
    );
  }
}
