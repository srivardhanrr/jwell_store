import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/config/images.dart';

import '../../domain/entities/task.dart';

class CategoryView extends StatelessWidget {
  final Task task;
  const CategoryView({
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
                  width: double.infinity,
                  height: 200,
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
                      task.image,
                      height: 200,
                      width: double.infinity,
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
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent
                              ]))),
                ),
                Positioned(
                  left: 15,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              Images.appIcon,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(task.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ).animate().fade(),
                // Positioned(
                //   left: 60,
                //   bottom: 30,
                //   child: Text(task.name,
                //       style: TextStyle(color: Colors.white, fontSize: 20)),
                // ).animate().fade(),
              ],
            ),
            const SizedBox(height: 20),
            // Text(
            //   "  ${task.name}",
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //     fontFamily: "",
            //   ),
            // ).animate().fade().slideY(
            //       duration: const Duration(milliseconds: 200),
            //       begin: 1,
            //       curve: Curves.easeInSine,
            //     ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
