import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/config/images.dart';

import '../../domain/entities/task.dart';

class CatView extends StatelessWidget {
  final Task task;
  const CatView({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/cat/${task.id}');
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Positioned(
                  // right: product.data['\$id'] == 2 ? 0 : 20.w,
                  // bottom: -80.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      task.imageUrl[0],
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                      // fit: BoxFit.fitHeight,
                    ).animate().slideX(
                          duration: const Duration(milliseconds: 200),
                          begin: 1,
                          curve: Curves.easeInSine,
                        ),
                  ),
                ),
                Positioned(
                  left: 15,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () => {},
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        Images.appIcon,
                        // color: Colors.red,
                      ),
                    ),
                  ),
                ).animate().fade(),
              ],
            ),
            const SizedBox(height: 10),
            Text(task.name).animate().fade().slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
            const SizedBox(height: 5),
            Text((task.category).toString()).animate().fade().slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 2,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
