import 'package:flutter/material.dart';

import '../../../../config/images.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.dropIconBlack,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "MOTHI",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
        ),
      ]),
    );
  }
}
