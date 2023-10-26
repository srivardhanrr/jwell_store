import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/constants.dart';
import 'config/go_router.dart';
import 'config/theme.dart';

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowMaterialGrid: false,
      theme: lightTheme,
      routerConfig: router,
      title: appTitle,
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
