import 'package:flutter/material.dart';
import 'package:jwell_store/config/images.dart';

class ImmerseToDoLogo extends StatelessWidget {
  final double height;
  const ImmerseToDoLogo({super.key, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Images.appIcon,
      height: 30,
    );
  }
}
