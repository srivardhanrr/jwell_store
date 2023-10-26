import 'package:core/core.dart';
import 'package:jwell_store/features/home/home.dart';
import 'package:jwell_store/features/products/products.dart';
import 'package:jwell_store/features/settings/settings.dart';
import 'package:jwell_store/features/tasks/tasks.dart';

import 'auth/auth.dart';
import 'onboarding/onboarding.dart';

List<Feature> features = [
  OnboardingFeature(),
  AuthFeature(),
  HomeFeature(),
  TasksFeature(),
  ProductsFeature(),
  SettingsFeature(),
];
