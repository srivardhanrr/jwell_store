import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/features/home/presentation/screens/home_screen.dart';

import '../features/auth/auth.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, ref) {
    var currentRoute = GoRouter.of(context).location;
    var authState = ref.watch(authStateProvider);
    var routeIndex = [
      HomeScreen.routePath,
      SettingsScreen.routePath,
      "",
      HomeScreen.routePath,
      SettingsScreen.routePath,
    ].indexOf(currentRoute);

    if (authState is Unauthenticated) {
      return const SizedBox();
    }

    return Scaffold(
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routeIndex != -1 ? routeIndex : 0,
        onTap: (index) {
          if (index == 0) {
            context.go(HomeScreen.routePath);
          }
          if (index == 1) {
            context.go(SettingsScreen.routePath);
          }
          if (index == 3) {
            context.go(HomeScreen.routePath);
          }
          if (index == 4) {
            context.go(SettingsScreen.routePath);
          }
        },
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Projects",
          ),
          BottomNavigationBarItem(
            icon: FloatingActionButton(
              mini: true,
              onPressed: () {},
              child: const Icon(Icons.favorite_border),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Calendar",
          ),
          const BottomNavigationBarItem(
            icon: Icon(FeatherIcons.user),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
