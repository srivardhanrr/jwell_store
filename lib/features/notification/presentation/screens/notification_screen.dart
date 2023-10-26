import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationScreen extends ConsumerWidget {
  static String routePath = "/notification";
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications"),
          ],
        ),
      ),
    );
  }
}
