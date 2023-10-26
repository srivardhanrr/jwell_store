import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/features/category/presentation/widgets/tasks_list_view.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../auth/presentation/states/auth_state.dart';
import '../widgets/greetings_view.dart';

class HomeScreen extends ConsumerWidget {
  static String routePath = "/";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authStateProvider, (previous, next) async {
      if (next is Unauthenticated) {
        context.go(LoginScreen.routePath);
        await ref.read(authStateProvider.notifier).logout();
      }
    });
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreetingsView(),
          // Padding(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 15,
          //       vertical: 10,
          //     ),
          //     child: Text("Categories",
          //         style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //               fontWeight: FontWeight.w600,
          //             ))),
          Expanded(child: CategoryListView()),
        ],
      ),
    );
  }
}
